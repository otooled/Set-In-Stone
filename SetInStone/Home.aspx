<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Home.aspx.cs" Inherits="SetInStone.WebForm1" %>
<%@ Import namespace="System.Web.Optimization" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <link href="HomeSS.css" rel="stylesheet" />
    <meta content='IE=EmulateIE7' http-equiv='X-UA-Compatible' />
    <meta content='width=1100' name='viewport' />
    <meta content='text/html; charset=UTF-8' http-equiv='Content-Type' />
    
    <%--<script src="Scripts/three.min.js"></script>
    <script src="Scripts/TrackballControls.js"></script>
    <script src="Scripts/Detector.js"></script>
    <script src="Scripts/stats.min.js"></script>
    <script src="Scripts/dat.gui.min.js"></script>--%>    <%: Styles.Render("~/Content/bootstrap.css") %>  
    <%: Scripts.Render("~/bundles/jQuery") %>
   
    <script>
        var renderer, scene, camera, controls, stats;
        var light, geometry, material, mesh, np;
        var clock = new THREE.Clock();
        var renderers = [];

        //Height of pyramid
        var Pyramid_Height = null;
        
        //This will act as width & length as slab
        var Slab_Width = null;
    </script>
    <title>Set In Stone</title>
    

</head>
    <body class='loading variant-light'>
        <div class="DropdownDiv">
            <select>
                <option value="PierCap">Pier Cap</option>
                <option value="CounterTop">Counter Top</option>
            </select>
        </div>

        <div id='header-inner'>
            <div class='titlewrapper'>
                </div>

        </div>

        <div class='post-body entry-content' id='post-body-6472318144316037563' itemprop='description articleBody'>

            <script type='text/javascript'>
                init();

                function init() {
                    d = document.getElementById('post-body-6472318144316037563');
                    // d = document.body;
                    // console.log('hi ', d);
                    renderer = new THREE.WebGLRenderer({ antialias: true });
                    renderer.setSize(640, 320);
                    renderer.shadowMapEnabled = true;
                    renderer.shadowMapSoft = true;
                    renderer.domElement.style.border = '5px solid black';
                    renderer.domElement.style.backgroundColor = '#000';
                    //renderer.domElement.style.font = '12px bold monospace';
                    //renderer.domElement.style.textAlign = 'center';
                    d.appendChild(renderer.domElement);

                    var light, geometry, color, material, mesh, box1, pyrimid, cone;

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
                    

                    //color of slab
                    color = 0x969696;

                    material = new THREE.MeshPhongMaterial({ color: color, ambient: color, transparent: true });                               

                    //slab creation and position setting
                    slab = new THREE.Mesh(geometry, material);
                    slab.castShadow = true;
                    slab.position.set(0, 12, 0);
                    
                    //create the pyrimid shape
                    pyrimid = new THREE.CylinderGeometry(0, 70, 10, 4, 1);

                    //add the pyrimid to the scene
                    pyrimid = new THREE.Mesh(pyrimid, material);
                    pyrimid.position.set(0, 24.5, 0);
                    pyrimid.rotation.y = Math.PI * 45 / 180;

                    scene.add(slab);
                    scene.add(pyrimid);

                    //funtion to manipulated slab shape
                    var slabConfigData = function () {
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
                        };
                    };
                    
                    //funtion to manipulated pryimed shape
                    var pyrimidConfigData = function () {
                        this.scaleX = 1.0;
                        this.scaleY = 1.0;
                        this.scaleZ = 1.0;
                        
                        this.wireframe = false;
                        this.opacity = 'full';
                        this.doScale = function () {
                            callback = function () {
                                var tim = clock.getElapsedTime() * 0.7;
                                pyrimid.scale.x = 1 + Math.sin(tim);
                                pyrimid.scale.y = 1 + Math.cos(1.5798 + tim);
                                pyrimid.scale.z = 1 + Math.cos(1.5798 + tim) * Math.cos(tim);
                                
                            }
                        };
                    };
                    
                    
                    
                    var slabConfig = new slabConfigData();
                    var slabGui = new dat.GUI();
                    var guiSlab = slabGui.addFolder('Slab ~ Scale');

                    //scale for pyrimid top
                    var pyrimidConfig = new pyrimidConfigData();
                    var pyrimidGui = new dat.GUI();
                    var guiPyrimid = pyrimidGui.addFolder('Pyramid ~ Scale');

                    //add slab scale control
                    guiSlab.open();
                    
                    //Change slab deminisions & move pyrimid in accordance with the altered slab
                    guiSlab.add(slabConfig, 'scaleY', 0.5, 2).onChange(function () {

                        // var tim2 = clock.getElapsedTime() * 2.7;
                        //slab.scale.x = 1 + Math.sin(tim);
                        //var  speed = 1 + Math.cos(2.5798 + tim2);
                        // slab.scale.z = 1 + Math.cos(1.5798 + tim) * Math.cos(tim);
                        slab.scale.y = (slabConfig.scaleY);

                        //This moves the slab and pyrimid as one but there is a gap between the objects
                        pyrimid.position.y = (slabConfig.scaleY * slab.position.y) + (slab.position.y + slab.position.y) * 0.5;

                        //Past attempts to manipulate shapes as one

                        //pyrimid.position.y = slab.position.y + slab.geometry.y / 2 + pyrimid.scale.y / 2;// (slab.position.y +20) ;
                        // pyrimid.position.y = (box1Config.scaleY * 7) + (18);
                        //var differnece = pyrimid.position.y - slab.position.y;
                        //pyrimid.position.y = (differnece + slab.position.y);

                        //pyrimid.position.y = slab.scale.y;

                    });
                    
                    //The following controls the x axis which I'm not working on yet
                    guiSlab.add(slabConfig, 'scaleX', 0.5, 2).step(.01).onChange(function () {
                        slab.scale.x = (slabConfig.scaleX);
                        slab.scale.z = (slabConfig.scaleX);
                        pyrimid.scale.x = (slabConfig.scaleX);
                        pyrimid.scale.z = (slabConfig.scaleX);
                        //pyrimid.scale.z = (slab.scale.z);
                    });
                    
                    //Z co-ordinates for slab - not working on it yet

                    guiSlab.add(slabConfig, 'scaleZ', 0, 2).onChange(function () {
                        slab.scale.z = (slabConfig.scaleZ);

                    });
                    
                    //add pryimid scale control
                    guiPyrimid.open();
                    
                    
                    guiPyrimid.add(pyrimidConfig, 'scaleY', 0, 2).onChange(function () {
                        pyrimid.scale.y = (pyrimidConfig.scaleY);

                        Pyramid_Height = pyrimid.scale.y;

                        //Past attempts at controlling shapes as one on screen
                        
                        //slab.scale.z = slab.scale.z + 1;
                        //var slabposition = slab.position.y ;

                        //slab.position.y = (coneConfig.scaleY + pyrimid.position.y) + (pyrimid.position.y + pyrimid.position.y)*0.5;
                        //pyrimid.position.y = coneConfig.scaleY + 12;
                        
                        //pyrimid.position.y = (box1Config.scaleY * slab.position.y) + (slab.position.y + slab.position.y)*0.5;
                        //pyrimid.position.y = (coneConfig.scaleY*7)+18.5;
                        // .step(.01)
                    });
                    
                    //add pryimid for scale controls - X axis
                    
                    guiPyrimid.add(pyrimidConfig, 'scaleX', 0, 2).onChange(function () {
                        pyrimid.scale.x = (pyrimidConfig.scaleX);
                        pyrimid.scale.z = (pyrimidConfig.scaleX);
                        slab.scale.x = (pyrimidConfig.scaleX);
                        slab.scale.z = (pyrimidConfig.scaleX);
                    });

                    //guiPyrimid.add(pyrimidConfig, 'scaleZ', 0, 2).onChange(function() {
                    //    pyrimid.scale.z = (pyrimidConfig.scaleZ);
                    //    pyrimid.scale.x = (pyrimidConfig.scaleZ);
                    //});



                    
                   // slab.scale.y = (pyrimid.scale.y);
                   
                    
                    
                    
                    function callback() { return; }
                    renderers.push({ renderer: renderer, scene: scene, camera: camera, controls: controls, callback: callback });                  

                }

                //function getCoords() {
                    
                //    alert(displayCo);

                //}
                
                function JavaScriptFunction() {
                    var JavaScriptVar = Pyramid_Height;
                    document.getElementById('<%= Hidden1.ClientID %>').value = JavaScriptVar;
        }

                //document.getElementById('PYS').value = pyrimid.scale.y;

            </script>

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
            <form id="fmContronls" runat="server">
                <%--<input type="hidden" name="PHeight" id="PYS" value="" runat="server" />--%>
                
                <%--Start of Ajax commands--%>
                <asp:ScriptManager ID="MainScriptManager" runat="server" />
                
               

                <%-- Connection to test database--%>
                <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:StoneTestConnectionString %>" SelectCommand="SELECT * FROM [Stone]"></asp:SqlDataSource>
                
                <%--This div gets updated using Ajax--%>
                <div align="center">
                    <asp:UpdatePanel runat="server" ID="UpdatePanel" UpdateMode="Conditional">
                        <Triggers>
                            <asp:AsyncPostBackTrigger ControlID="btnCalculate" />
                        </Triggers>
                        <ContentTemplate>
                            <label>Stone Height</label>
                            <asp:TextBox ID="txtStoneHeight" runat="server"></asp:TextBox>
                            
                            <br />
                            <label>Stone Width</label>
                            <asp:TextBox ID="txtStoneWidth" runat="server"></asp:TextBox>
                            <br />

                            <asp:DropDownList class="btn btn-info dropdown-toggle" data-toggle="dropdown" ID="DropDownList1" runat="server" DataSourceID="SqlDataSource1" DataTextField="StoneType" DataValueField="StoneCost">
                            </asp:DropDownList>
                            <asp:Button class="btn btn-success" runat="server" ID="btnCalculate" Text="Calculate Cost" OnClick="btnCalculate_Click" />
                            <br />
                            <asp:Label runat="server" ID="lblAnswer"></asp:Label>
                            <asp:Button ID="Button1" runat="server" Text="Button" OnClientClick="JavaScriptFunction()" onclick="Button1_Click" /> 
            
            <asp:HiddenField ID="Hidden1" runat="server" />
        <asp:TextBox ID="TextBox1" runat="server"></asp:TextBox>
                        </ContentTemplate>
                    </asp:UpdatePanel>
                    <%--Calculate button and drop down menu--%>
                </div>
               
        
        <asp:Label ID="lblTest" runat="server" Text="Label"></asp:Label>
            
            </form>

        </div>
        

    </body>
</html>
