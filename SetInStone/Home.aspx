    <%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Home.aspx.cs" Inherits="SetInStone.WebForm1" %>

<%@ Import Namespace="System.Web.Optimization" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <%--<link href="HomeSS.css" rel="stylesheet" />--%>
    <meta content='IE=EmulateIE7' http-equiv='X-UA-Compatible' />
    <meta content='width=1100' name='viewport' />
    <meta content='text/html; charset=UTF-8' http-equiv='Content-Type' />
    <link rel="stylesheet" href="/resources/demos/style.css"/>
    <link rel="stylesheet" href="//code.jquery.com/ui/1.11.4/themes/smoothness/jquery-ui.css"/>
    <style>
     body { font-size: 62.5%; }
    label, input { display:block; }
    input.text { margin-bottom:12px; width:95%; padding: .4em; }
    fieldset { padding:0; border:0; margin-top:25px; }
    h1 { font-size: 1.2em; margin: .6em 0; }
    .ui-dialog .ui-state-error { padding: .3em; }
    .validateTips { border: 1px solid transparent; padding: 0.3em; }
        </style>
    <%: Styles.Render("~/Content/bootstrap.css", "~/Content/HomePage.css") %> 
    <%: Scripts.Render("~/bundles/jQuery") %>
    <script>
        $(function () {
            var dialog, form,

                // From http://www.whatwg.org/specs/web-apps/current-work/multipage/states-of-the-type-attribute.html#e-mail-state-%28type=email%29
                emailRegex = /^[a-zA-Z0-9.!#$%&'*+\/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?)*$/,
                name = $("#name"),
                email = $("#email"),
                password = $("#password"),
                allFields = $([]).add(name).add(email).add(password),
                tips = $(".validateTips");

            function updateTips(t) {
                tips
                    .text(t)
                    .addClass("ui-state-highlight");
                setTimeout(function () {
                    tips.removeClass("ui-state-highlight", 1500);
                }, 500);
            }

            function checkLength(o, n, min, max) {
                if (o.val().length > max || o.val().length < min) {
                    o.addClass("ui-state-error");
                    updateTips("Length of " + n + " must be between " +
                        min + " and " + max + ".");
                    return false;
                } else {
                    return true;
                }
            }

            function checkRegexp(o, regexp, n) {
                if (!(regexp.test(o.val()))) {
                    o.addClass("ui-state-error");
                    updateTips(n);
                    return false;
                } else {
                    return true;
                }
            }

            function addUser() {
                var valid = true;
                allFields.removeClass("ui-state-error");

                //valid = valid && checkLength(name, "username", 3, 16);
                //valid = valid && checkLength(email, "email", 6, 80);
                //valid = valid && checkLength(password, "password", 5, 16);

                //valid = valid && checkRegexp(name, /^[a-z]([0-9a-z_\s])+$/i, "Username may consist of a-z, 0-9, underscores, spaces and must begin with a letter.");
                valid = valid && checkRegexp(email, emailRegex, "eg. ui@jquery.com");
                //valid = valid && checkRegexp(password, /^([0-9a-zA-Z])+$/, "Password field only allow : a-z 0-9");

                if (valid) {
                    $("#users tbody").append("<tr>" +
                        "<td>" + name.val() + "</td>" +
                        "<td>" + email.val() + "</td>" +
                        "<td>" + password.val() + "</td>" +
                        "</tr>");
                    dialog.dialog("close");
                }
                return valid;
            }

            dialog = $("#dialog-form").dialog({
                autoOpen: false,
                height: 550,
                width: 350,
                modal: true,
                buttons: {
                    "Save Quote": addUser,
                    Cancel: function () {
                        dialog.dialog("close");
                    }
                },
                close: function () {
                    form[0].reset();
                    allFields.removeClass("ui-state-error");
                }
            });

            form = dialog.find("form").on("submit", function (event) {
                event.preventDefault();
                addUser();
            });

            $("#create-user").button().on("click", function () {
                dialog.dialog("open");
            });
            
            
            
        });
    </script>
    <script>
        var renderer, scene, camera, controls, stats;
        var light, geometry, material, mesh, np;
        var clock = new THREE.Clock();
        var renderers = [];

        //Height of pyramid
        var Pyramid_Height = null;

        //This will act as width & length as slab
        var Slab_Width = null;
        var Slab_Length = null;

        var Slab_Height = null;
        

        var slab;
        var newPyramid;
        var parameters;
        var gui;
        var folder1;
        var slabX;
        var slabY;
        var slabZ;
        var pyramidY;
        //default size for new pier cap
        var SLAB_WIDTH = 80; SLAB_LENGTH = 100; SLAB_HEIGHT = 25; PYRAMID_HEIGHT = 20;
        //max dimensions for pier caps
        var MIN_SLAB_WIDTH = 400; MIN_SLAB_LENGTH = 400; MIN_SLAB_HEIGHT = 150; MIN_PYRAMID_HEIGHT = 0;
        var MAX_SLAB_WIDTH = 1200; MAX_SLAB_LENGTH = 1200; MAX_SLAB_HEIGHT = 350; MAX_PYRAMID_HEIGHT = 300;
    </script>
    <title>Set In Stone</title>
Set In Stone</title>


</head>
<body >
    
    <div id="Title">
      </div>

    <div  id='MainGraphic'>
        
        
        <script type='text/javascript'>
           // var controls, stats;
            init();

            function init() {
                mainGraphic = document.getElementById('MainGraphic');
                // d = document.body;
                // console.log('hi ', d);
                
                renderer = new THREE.WebGLRenderer({ antialias: true });
                renderer.setSize(640, 320);
                renderer.shadowMapEnabled = true;
                renderer.shadowMapSoft = true;
                renderer.domElement.style.border = '5px solid black';
                renderer.domElement.style.backgroundColor = '#d6dbe3';
                //renderer.domElement.style.font = '12px bold monospace';
                //renderer.domElement.style.textAlign = 'center';
                mainGraphic.appendChild(renderer.domElement);

                var light, geometry, color, material, pyramid;
                
                //Load textures
                var stoneTex =  new THREE.ImageUtils.loadTexture("Textures/gridcomb.gif");
                
                stoneTex.minFilter= THREE.LinearFilter;
                stoneTex.magFilter = THREE.LinearFilter;
                stoneTex.wrapS = THREE.RepeatWrapping;
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

                //var quaternion = new THREE.Quaternion();
                //quaternion.setFromAxisAngle(new THREE.Vector3(0, 1, 0), Math.PI / 2);
                //var vector = new THREE.Vector3(1, 10, 20);
                //vector.applyQuaternion(quaternion);

                //Create the slab
                geometry = new THREE.CubeGeometry(100, 15, 100);

                //color of slab color: color , ambient: color, transparent: true
                // color = 0x969696;
                gui = new dat.GUI();

                parameters =
                {
                    Length: (SLAB_LENGTH * 10), Width: (SLAB_WIDTH * 10), Slab_Height: (SLAB_HEIGHT * 10), Point_Height: (PYRAMID_HEIGHT * 10),    //these will be read from the DB for previous quotes!
                    stone: "Granite",
                    reset: function () { resetPier() }
                };

                folder1 = gui.addFolder('Pier Cap Dimensions (mm)');
                slabX = folder1.add(parameters, 'Width').min(MIN_SLAB_LENGTH).max(MAX_SLAB_LENGTH).step(1).listen();
                slabZ = folder1.add(parameters, 'Length').min(MIN_SLAB_WIDTH).max(MAX_SLAB_WIDTH).step(1).listen();
                slabY = folder1.add(parameters, 'Slab_Height').min(MIN_SLAB_HEIGHT).max(MAX_SLAB_HEIGHT).step(1).listen();
                pyramidY = folder1.add(parameters, 'Point_Height').min(MIN_PYRAMID_HEIGHT).max(MAX_PYRAMID_HEIGHT).step(1).listen();
                folder1.open();
                
                var cubeMaterial = gui.add(parameters, 'stone', ["Granite", "Sandstone", "Limestone", "Wireframe"]).name('Stone Type').listen();
                cubeMaterial.onChange(function (value)
                { updateProduct(); });
                
                function updateProduct() {
                    var value = parameters.stone;
                    var newMaterial;
                    if (value == "Granite"){
                        newMaterial = new THREE.MeshLambertMaterial({map: THREE.ImageUtils.loadTexture("Textures/Granite.jpg"), shading: THREE.FlatShading, overdraw : true});
                    }
                    else if (value == "Sandstone") {
                        newMaterial = new THREE.MeshLambertMaterial({ map: THREE.ImageUtils.loadTexture("Textures/sstone.jpg") });
                    }
                    else if (value == "Limestone"){
                        newMaterial = new THREE.MeshLambertMaterial({ map: THREE.ImageUtils.loadTexture("Textures/Limestone.jpg") });
                    }
                    else // (value == "Wireframe")
                        newMaterial = new THREE.MeshBasicMaterial({ wireframe: true });

                    slab.material = newMaterial;
                    pyramid.material = newMaterial;
                    
                animate();
            }

                material = new THREE.MeshPhongMaterial({ map: stoneTex, side: THREE.DoubleSide,  transparent: false, opacity: 100 });

                //slab creation and position setting
                slab = new THREE.Mesh(geometry, material);
                slab.castShadow = true;
                slab.position.set(0, SLAB_HEIGHT / 2, 0); //(0, 12, 0);
                

                //var pyramidGeom = new THREE.Geometry();
                //pyramidGeom.vertices = [  // array of Vector3 giving vertex coordinates
                //        new THREE.Vector3(SLAB_WIDTH / 2, 0, SLAB_LENGTH / 2),    // vertex number 0
                //        new THREE.Vector3(SLAB_WIDTH / 2, 0, SLAB_LENGTH / -2),   // vertex number 1
                //        new THREE.Vector3(SLAB_WIDTH / -2, 0, SLAB_LENGTH / -2),  // vertex number 2
                //        new THREE.Vector3(SLAB_WIDTH / -2, 0, SLAB_LENGTH / 2),   // vertex number 3
                //        new THREE.Vector3(0, PYRAMID_HEIGHT, 0)     // vertex number 4
                //];


                //create the pyrimid shape
                pyramid = new THREE.CylinderGeometry(0, 70, 10, 4, 1);

                //add the pyrimid to the scene
                pyramid = new THREE.Mesh(pyramid, material);//pyramidGeom
                pyramid.position.set(0, SLAB_HEIGHT , 0); //(0, 24.5, 0);
                pyramid.rotation.y = Math.PI * 45 / 180;

                scene.add(slab);
                scene.add(pyramid);
                
                //X & Z co-ordinates of pryamid

               
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

                //var slabConfig = new slabConfigData();
                //var slabGui = new dat.GUI();
                //var guiSlab = slabGui.addFolder('Slab ~ Scale');
                
                ////scale for pyrimid top
                //var pyrimidConfig = new pyrimidConfigData();
                //var pyrimidGui = new dat.GUI();
                //var guiPyrimid = pyrimidGui.addFolder('Pyramid ~ Scale');
              
                
                ////add slab scale control
                //guiSlab.open();
                

                slabX.onChange(function(value) {
                    slab.scale.x = value / (SLAB_WIDTH * 10);
                    pyramid.scale.x = slab.scale.x;
                    pyramid.scale.z = slab.scale.x;
                    //Put Y scale value in global variable
                    Slab_Length = slab.scale.x;
                });

                slabY.onChange(function(value) {
                    slab.scale.y = value / (SLAB_HEIGHT * 10);
                    slab.position.y = (slab.scale.y * SLAB_HEIGHT) / 2;
                    pyramid.position.y = (slab.scale.y * SLAB_HEIGHT);
                    Slab_Height = slab.scale.y;
                });

                slabZ.onChange(function(value) {
                    slab.scale.z = value / (SLAB_LENGTH * 10);
                    pyramid.scale.x = slab.scale.z;
                    pyramid.scale.z = slab.scale.z;
                    Slab_Width = slab.scale.z;
                });

                pyramidY.onChange(function(value) {
                    pyramid.scale.y = value / (PYRAMID_HEIGHT * 10);
                    slab.position.y = (pyramid.scale.y * PYRAMID_HEIGHT) / 2;
                    Pyramid_Height = pyramid.scale.y;
                    //slab.position.y = (slab.scale.y * 25) / 2;
                    //pyramid.position.y = (slab.scale.y * 25);
                });

                ////Change slab deminisions & move pyrimid in accordance with the altered slab
                //guiSlab.add(slabConfig, 'scaleY', 0.5, 1.5).onChange(function () {

                    
                //    slab.scale.y = (slabConfig.scaleY);

                //    //Put Y scale value in global variable
                //    Slab_Height = slab.scale.y;

                //    //This moves the slab and pyrimid as one but there is a gap between the objects
                //    pyramid.position.y = (slabConfig.scaleY * slab.position.y) + (slab.position.y + slab.position.y) * 0.5;

                   

                //});

                ////The following controls the x axis which I'm not working on yet
                //guiSlab.add(slabConfig, 'scaleX', 0.5, 1.5).step(.01).onChange(function () {
                //    slab.scale.x = (slabConfig.scaleX);
                    

                //    //Puts value of X co-ordinate in globally declared variable
                //    //Slab_Width = slab.scale.x;
                //    Slab_Length = slab.scale.x;
                //});

                ////Z co-ordinates for slab - not working on it yet

                //guiSlab.add(slabConfig, 'scaleZ', 0.5, 1.5).onChange(function () {
                //    slab.scale.z = (slabConfig.scaleZ);

                //    //Puts value of Z co-ordingate in globally declared variable
                //    //Slab_Length = slab.scale.z;
                //    Slab_Width = slab.scale.z;
                //});
                
                ////add pryimid scale control
                //guiPyrimid.open();

                ////Pryamid scale Y co-ordinate
                //guiPyrimid.add(pyrimidConfig, 'scaleY', 0, 1).onChange(function () {

                //    pyramid.scale.y = (pyrimidConfig.scaleY);

                //    //Puts value of Y co-ordinate in globally declared variable
                //    Pyramid_Height = pyramid.scale.y;

                  
                //});

                //guiPyrimid.add(pyrimidConfig, 'scaleX', 0, 1.5).onChange(function () {
                //    pyrimid.scale.x = (pyrimidConfig.scaleX);
                //    pyrimid.scale.z = (pyrimidConfig.scaleX);
                //    slab.scale.x = (pyrimidConfig.scaleX);
                //    slab.scale.z = (pyrimidConfig.scaleX);


                //});
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

            <%-- Connection to test database--%>
            <%--This div gets updated using Ajax--%>
            <div id="costControls">
                <asp:UpdatePanel runat="server" ID="UpdatePanel" UpdateMode="Conditional">
                    <Triggers>
                        <asp:AsyncPostBackTrigger ControlID="btnCalculate" />
                    </Triggers>
                    <ContentTemplate>
                        <asp:DropDownList ID="ddlProductType" runat="server" class="btn btn-info dropdown-toggle" data-toggle="dropdown"/>
                        <asp:DropDownList ID="ddlStoneType" runat="server" class="btn btn-info dropdown-toggle" data-toggle="dropdown" 
                            OnSelectedIndexChanged="ddlStoneType_SelectedIndexChanged" AutoPostBack="True" 
                            onchange="stoneTexture();"  />
                         <div id="ProvisionalCosts"  >
                            <br/>
                            <br />
                            <asp:Label runat="server" ID="lblTotalCost" Visible="False"></asp:Label>
                             <br/>
                        </div>
                        <br />

                        <asp:Button class="btn btn-success" runat="server" ID="btnCalculate" Text="Calculate Cost" OnClick="btnCalculate_Click"
                              OnClientClick="DisplayPryHeight(); DisplaySlabHeight();
        DisplaySlabWidth();  DisplaySlabLength();" />
                        <asp:Button runat="server" class="btn btn-warning" ID="btnSaveConfirm" Text="Save Quote / Place Order"
                             OnClick="btnSaveConfirm_Click" />
                        <br />

                       
                        <%--Hidden fields for slab and pryamid measurements--%>
                        <asp:HiddenField ID="SlabLength" runat="server"/>
                        <asp:HiddenField ID="SlabWidth" runat="server" />
                        <asp:HiddenField ID="PryHeight" runat="server" />
                        <asp:HiddenField ID="SlabHeight" runat="server" />
                        
                        <%--<asp:HiddenField runat="server" ID="stoneTextureHF"/>--%>

                        <asp:Label runat="server" ID="lblCalculateAnswer"></asp:Label>
                        <asp:Label runat="server"></asp:Label>
                        
                    </ContentTemplate>
                </asp:UpdatePanel>
            </div>
         
        </form>
   
</body>
</html>
