﻿<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ProductPage.aspx.cs" Inherits="SetInStone.WebForm1" UnobtrusiveValidationMode="None" %>

<%@ Import Namespace="System.Web.Optimization" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <%--<link href="HomeSS.css" rel="stylesheet" />--%>
    <meta content='IE=EmulateIE7' http-equiv='X-UA-Compatible' />
    <meta content='width=1100' name='viewport' />
    <meta content='text/html; charset=UTF-8' http-equiv='Content-Type' />
    <link rel="stylesheet" href="/resources/demos/style.css" />
    <link rel="stylesheet" href="http://localhost:55153/code.jquery.com/ui/1.11.4/themes/smoothness/jquery-ui.css" />

    <%: Styles.Render("~/Content/bootstrap.css", "~/Content/ProductPage.css") %>    <%: Scripts.Render("~/bundles/jQuery") %>

    <script>

        var renderer, scene, camera, controls, stats;
        var light, geometry, material, mesh, np;
        var clock = new THREE.Clock();
        var renderers = [];

        //Height of pyramid
        var Pyramid_Height = 1;

        //This will act as width & length as slab
        var Slab_Width = 1;
        var Slab_Length = 1;
        var Slab_Height = 1;

        //Global variables
        var slab;

        var parameters;
        var gui;
        var folder1;
        var slabX;
        var slabY;
        var slabZ;
        var pyramidY;
        var light, slabGeometry, slabMaterial, color, pyramid, assignUVs;

        //default size for new pier cap
        var SLAB_WIDTH = 80; SLAB_LENGTH = 100; SLAB_HEIGHT = 25; PYRAMID_HEIGHT = 20;

        //max dimensions for pier caps
        var MIN_SLAB_WIDTH = 400; MIN_SLAB_LENGTH = 400; MIN_SLAB_HEIGHT = 150; MIN_PYRAMID_HEIGHT = 0;
        var MAX_SLAB_WIDTH = 1200; MAX_SLAB_LENGTH = 1200; MAX_SLAB_HEIGHT = 350; MAX_PYRAMID_HEIGHT = 300;
    </script>

    <title>Set In Stone</title>
</head>
<body>

    <br />
    <br />
    <div id="divTitle">
        <label>Set In Stone</label>
    </div>
    <div id='MainGraphic'>


        <script type='text/javascript'>
            // var controls, stats;
            init();

            function init() {
                mainGraphic = document.getElementById('MainGraphic');
                // d = document.body;
                // console.log('hi ', d);

                renderer = new THREE.WebGLRenderer({ antialias: true });
                renderer.setSize(740, 320);
                renderer.shadowMapEnabled = true;
                renderer.shadowMapSoft = true;
                renderer.domElement.style.border = '5px solid white';

                mainGraphic.appendChild(renderer.domElement);

                color = new THREE.Color(0xffffff);

                //Load textures
                var stoneTex = new THREE.ImageUtils.loadTexture("Textures/gridcomb.gif");
                stoneTex.wrapS = THREE.RepeatWrapping;
                stoneTex.anisotropy = 16;
                stoneTex.minFilter = THREE.LinearFilter;
                stoneTex.magFilter = THREE.LinearFilter;

                stoneTex.repeat.x = 1;
                stoneTex.repeat.y = 1;

                scene = new THREE.Scene();

                camera = new THREE.PerspectiveCamera(40, window.innerWidth / window.innerHeight, 1, 1000);
                camera.position.set(100, 100, 200);

                controls = new THREE.TrackballControls(camera, renderer.domElement);

                light = new THREE.AmbientLight(0xffffff);
                scene.add(light);

                light = new THREE.SpotLight(0xffffff);
                light.position.set(-100, 100, -100);
                light.castShadow = true;
                scene.add(light);

                //Create the slab
                slabGeometry = new THREE.CubeGeometry(SLAB_WIDTH, SLAB_HEIGHT, SLAB_LENGTH); //(100, 15, 100);
                slabMaterial = new THREE.MeshPhongMaterial({ map: stoneTex, side: THREE.DoubleSide, transparent: false, opacity: 100 });

                slab = new THREE.Mesh(slabGeometry, slabMaterial);
                slab.castShadow = true;
                slab.position.set(0, SLAB_HEIGHT / 2, 0); //(0, 12, 0);

                scene.add(slab);

                //Create pyramid shape
                var pyramidGeom = new THREE.Geometry();
                pyramidGeom.vertices = [  // array of Vector3 giving vertex coordinates
                    new THREE.Vector3(SLAB_WIDTH / 2, 0, SLAB_LENGTH / 2),    // vertex number 0
                    new THREE.Vector3(SLAB_WIDTH / 2, 0, SLAB_LENGTH / -2),   // vertex number 1
                    new THREE.Vector3(SLAB_WIDTH / -2, 0, SLAB_LENGTH / -2),  // vertex number 2
                    new THREE.Vector3(SLAB_WIDTH / -2, 0, SLAB_LENGTH / 2),   // vertex number 3
                    new THREE.Vector3(0, PYRAMID_HEIGHT, 0)     // vertex number 4
                ];

                pyramidGeom.faces = [

                    new THREE.Face3(3, 0, 4), // faces are triangles
                    new THREE.Face3(0, 1, 4),
                    new THREE.Face3(1, 2, 4),
                    new THREE.Face3(2, 3, 4)
                ];
                pyramidGeom.dynamic = true;
                pyramidGeom.computeFaceNormals();
                pyramidGeom.computeVertexNormals();
                pyramidGeom.computeBoundingSphere();


                var pyramidMaterial = new THREE.MeshLambertMaterial({ wireframe: true, side: THREE.DoubleSide, transparent: false, opacity: 100 });// new THREE.LineBasicMaterial({ color: 0xffffff, opacity: 0.2 });
                pyramid = new THREE.Mesh(pyramidGeom, pyramidMaterial, new THREE.MeshFaceMaterial());
                //pyramid = new THREE.Mesh(pyramidGeom, pyramidMaterial);
                pyramid.position.set(0, SLAB_HEIGHT, 0);
                pyramid.overdraw = true;
                pyramid.castShadow = true;
                pyramid.receiveShadow = true;

                scene.add(pyramid);
                scene.add(new THREE.FaceNormalsHelper(pyramid));

                gui = new dat.GUI();

                parameters =
                    {
                        Length: (SLAB_LENGTH * 10), Width: (SLAB_WIDTH * 10), Slab_Height: (SLAB_HEIGHT * 10), Point_Height: (PYRAMID_HEIGHT * 10),    //these will be read from the DB for previous quotes!
                        stone: "Granite",
                        reset: function () { resetPier() }
                    };

                //Slider UI
                folder1 = gui.addFolder('Pier Cap Dimensions (mm)');
                slabX = folder1.add(parameters, 'Width').min(MIN_SLAB_LENGTH).max(MAX_SLAB_LENGTH).step(1).listen();
                slabZ = folder1.add(parameters, 'Length').min(MIN_SLAB_WIDTH).max(MAX_SLAB_WIDTH).step(1).listen();
                slabY = folder1.add(parameters, 'Slab_Height').min(MIN_SLAB_HEIGHT).max(MAX_SLAB_HEIGHT).step(1).listen();
                pyramidY = folder1.add(parameters, 'Point_Height').min(MIN_PYRAMID_HEIGHT).max(MAX_PYRAMID_HEIGHT).step(1).listen();
                folder1.open();

                var productMaterial = gui.add(parameters, 'stone', ["Granite", "Sandstone", "Limestone", "Wireframe"]).name('Stone Type').listen();
                productMaterial.onChange(function (value) {
                    updateSlab();
                    updatePyramid();
                });

                //change texture of slab when stone type is changed
                function updateSlab() {
                    var value = parameters.stone;
                    var newMaterial;
                    if (value == "Granite") {
                        newMaterial = new THREE.MeshLambertMaterial({ map: THREE.ImageUtils.loadTexture("Textures/granite2.jpg"), shading: THREE.FlatShading, overdraw: true });
                    }
                    else if (value == "Sandstone") {
                        newMaterial = new THREE.MeshLambertMaterial({ map: THREE.ImageUtils.loadTexture("Textures/sandstone2.jpg") });
                    }
                    else if (value == "Limestone") {
                        newMaterial = new THREE.MeshLambertMaterial({ map: THREE.ImageUtils.loadTexture("Textures/limestone2.jpg") });
                    }
                    else // (value == "Wireframe")
                        newMaterial = new THREE.MeshBasicMaterial({ wireframe: true });

                    slab.material = newMaterial;
                    //pyramid.material = newMaterial;   

                    animate();
                }

                //change texture of pyramid when stone type is changed
                function updatePyramid() {
                    var value = parameters.stone;
                    var newMaterial;
                    if (value == "Granite") {
                        newMaterial = new THREE.MeshBasicMaterial({ color: 0x808080 });//new THREE.MeshLambertMaterial({ map: THREE.ImageUtils.loadTexture("Textures/Granite.jpg"), shading: THREE.FlatShading, overdraw: true });
                    }
                    else if (value == "Sandstone") {
                        newMaterial = new THREE.MeshBasicMaterial({ color: 0xF4A460 });
                    }
                    else if (value == "Limestone") {
                        newMaterial = new THREE.MeshBasicMaterial({ color: 0x7C7062 });//new THREE.MeshBasicMaterial({ map: THREE.ImageUtils.loadTexture("Textures/Limestone.jpg")});
                    }
                    else // (value == "Wireframe")
                        newMaterial = new THREE.MeshBasicMaterial({ wireframe: true });

                    pyramid.material = newMaterial;
                    
                    animate();

                }

                //funtion to manipulated slab shape
                var slabConfigData = function () {
                    //slabDiv = document.getElementById('slabControls');
                    this.scaleX = 1.0;
                    this.scaleY = 1.0;
                    this.scaleZ = 1.0;
                    this.wireframe = false;
                    this.opacity = 'full';

                    this.doScale = function () {
                        callback = function () {
                            var tim = clock.getElapsedTime() * 0.7;
                            slab.scale.x = 1 + Math.sin(tim);
                            slab.scale.y = 1 + Math.cos(1.5798 + tim);
                            slab.scale.z = 1 + Math.cos(1.5798 + tim) * Math.cos(tim);
                        }
                        //slabDiv.appendChild(renderer.domElement);
                    };

                };

                //funtion to manipulated pryimed shape
                var pyrimidConfigData = function () {

                    //this.scaleX = 1.0;
                    this.scaleY = 1.0;
                    //this.scaleZ = 1.0;

                    this.wireframe = false;
                    this.opacity = 'full';

                    this.doScale = function () {
                        callback = function () {
                            var tim = clock.getElapsedTime() * 0.7;
                            //pyrimid.scale.x = 1 + Math.sin(tim);
                            pyramid.scale.y = 1 + Math.cos(1.5798 + tim);
                            //pyrimid.scale.z = 1 + Math.cos(1.5798 + tim) * Math.cos(tim);
                        }

                    };
                };

                //functions to alter shape with sliders
                slabX.onChange(function (value) {
                    slab.scale.x = value / (SLAB_WIDTH * 10);
                    pyramid.scale.x = slab.scale.x;
                    //pyramid.scale.z = slab.scale.x;

                    //Put X scale value in global variable
                    Slab_Length = slab.scale.x;
                });

                slabY.onChange(function (value) {
                    slab.scale.y = value / (SLAB_HEIGHT * 10);
                    slab.position.y = (slab.scale.y * 25) / 2;
                    pyramid.position.y = (slab.scale.y * 25);

                    //Put Y scale value in global variable
                    Slab_Height = slab.scale.y;
                });

                slabZ.onChange(function (value) {
                    slab.scale.z = value / (SLAB_LENGTH * 10);
                    //pyramid.scale.x = slab.scale.z;
                    pyramid.scale.z = slab.scale.z;

                    //Put Z scale value in global variable
                    Slab_Width = slab.scale.z;
                });

                pyramidY.onChange(function (value) {
                    pyramid.scale.y = value / (PYRAMID_HEIGHT * 10);
                    //slab.position.y = (pyramid.scale.y * PYRAMID_HEIGHT) / 2;

                    //Put pryamid Y scale value in global variable
                    Pyramid_Height = pyramid.scale.y;
                    //slab.position.y = (slab.scale.y * 25) / 2;
                    //pyramid.position.y = (slab.scale.y * 25);
                });


                function callback() { return; }
                renderers.push({ renderer: renderer, scene: scene, camera: camera, controls: controls, callback: callback });

            }

            //Functions to send co-ordinates of pryamid and slab to code behind
            function DisplaySlabHeight() {
                var GetSlabHeight = Slab_Height;
                document.getElementById('<%= SlabHeight.ClientID %>').value = GetSlabHeight;
            }

            function DisplaySlabWidth() {
                var GetSlabWidth = Slab_Width;
                document.getElementById('<%= SlabWidth.ClientID %>').value = GetSlabWidth;
            }

            function DisplaySlabLength() {
                var GetSlabLength = Slab_Length;
                document.getElementById('<%=SlabLength.ClientID %>').value = GetSlabLength;
            }

            function DisplayPryHeight() {
                var GetPryHeight = Pyramid_Height;
                document.getElementById('<%= PryHeight.ClientID %>').value = GetPryHeight;
            }

            //Stone texture
            // function stoneTexture() {
            //      var getStoneTexture = stoneTex;
            //    
            // }

        </script>

    </div>


    <script>
        //init();
        animate();

        function animate() {
            requestAnimationFrame(animate);
            render();
        }

        function render() {
            var tim = clock.getElapsedTime() * 0.15;
            for (var i = 0, l = renderers.length; i < l; i++) {
                var r = renderers[i];

                r.renderer.render(r.scene, r.camera);
                if (r.stats) { r.stats.update(); }
                if (r.callback) {
                    r.callback();
                } else {
                    r.camera.position.x = 20 * Math.cos(tim);
                    r.camera.position.y = 20 * Math.cos(tim);
                    r.camera.position.z = 20 * Math.sin(tim);
                }
                r.controls.update();
            }
        }

    </script>

    <form id="fmControls" runat="server">


        <%--Start of Ajax commands--%>
        <asp:ScriptManager ID="MainScriptManager" runat="server" />


        <%--This div gets updated using Ajax--%>
        <div id="costControls">
            <asp:UpdatePanel runat="server" ID="UpdatePanel" UpdateMode="Conditional">
                <Triggers>
                    <asp:AsyncPostBackTrigger ControlID="btnCalculate" />
                </Triggers>
                <ContentTemplate>
                    <%--                        <asp:DropDownList ID="ddlProductType" runat="server" class="btn btn-info dropdown-toggle" data-toggle="dropdown"/>--%>
                    <asp:DropDownList ID="ddlStoneType" runat="server" class="btn btn-info dropdown-toggle" data-toggle="dropdown"
                        OnSelectedIndexChanged="ddlStoneType_SelectedIndexChanged" AutoPostBack="True" />
                    <asp:TextBox runat="server" ID="txtQuantity" CssClass="TextBoxes" placeholder="Enter quantity here"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="rfvQuantity" runat="server" ControlToValidate="txtQuantity" ErrorMessage="Please enter no of products required" EnableClientScript="False"></asp:RequiredFieldValidator>
                    <asp:RegularExpressionValidator ID="RegularExpressionValidator1" runat="server" ControlToValidate="txtQuantity" ErrorMessage="Number only" ValidationExpression="^\d$"></asp:RegularExpressionValidator>
                    <div id="ProvisionalCosts">
                        <br />
                        <br />
                        <asp:Label runat="server" ID="lblTotalCost" Visible="False"></asp:Label>
                        <br />
                    </div>
                    <br />

                    <asp:Button CssClass="Buttons" runat="server" ID="btnCalculate" Text="Calculate Cost" OnClick="btnCalculate_Click"
                        OnClientClick="DisplayPryHeight(); DisplaySlabHeight();
        DisplaySlabWidth();  DisplaySlabLength();" />
                    <asp:Button runat="server" CssClass="Buttons" ID="btnSaveConfirm" Text="Save Quote / Place Order"
                        OnClick="btnSaveConfirm_Click" />
                    <asp:Button runat="server" ID="btnCancel" Text="Cancel" CssClass="Buttons" OnClick="btnCancel_Click" />
                    <br />


                    <%--Hidden fields for slab and pryamid measurements--%>
                    <asp:HiddenField ID="SlabLength" runat="server" />
                    <asp:HiddenField ID="SlabWidth" runat="server" />
                    <asp:HiddenField ID="PryHeight" runat="server" />
                    <asp:HiddenField ID="SlabHeight" runat="server" />

                    <%--<asp:HiddenField runat="server" ID="stoneTextureHF"/>--%>

                    <asp:Label runat="server" ID="lblCalculateAnswer" CssClass="Labels"></asp:Label>
                    <asp:Label runat="server"></asp:Label>

                </ContentTemplate>
            </asp:UpdatePanel>
        </div>

    </form>


</body>
</html>
