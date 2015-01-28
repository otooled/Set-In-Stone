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
    <script src="Scripts/dat.gui.min.js"></script>--%>    
    <%: Scripts.Render("~/bundles/jQuery") %>
   
    <script>
        var renderer, scene, camera, controls, stats;
        var light, geometry, material, mesh, np;
        var clock = new THREE.Clock();
        var renderers = [];

        //globlal variable to get one co-ordination value
        var displayCo = null;
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

                    //add the pyrimid (now called cone) to the scene
                    pyrimid = new THREE.Mesh(pyrimid, material);
                    pyrimid.position.set(0, 24.5, 0);
                    pyrimid.rotation.y = Math.PI * 45 / 180;

                    scene.add(slab);
                    scene.add(pyrimid);

                   

                    //funtion to manipulated slab shape
                    var slabConfigData = function () {
                        //this.scaleX = 1.0;
                        this.scaleY = 1.0;
                        //this.scaleZ = 1.0;
                        this.wireframe = false;
                        this.opacity = 'full';
                        this.doScale = function () {
                            callback = function () {
                                var tim = clock.getElapsedTime() * 0.7;
                                //slab.scale.x = 1 + Math.sin(tim);
                                slab.scale.y = 1 + Math.cos(1.5798 + tim);
                                //slab.scale.z = 1 + Math.cos(1.5798 + tim) * Math.cos(tim);
                            }
                        };
                    };
                    
                    //funtion to manipulated pryimed shape
                    var pyrimidConfigData = function () {
                        //this.scaleX = 1.0;
                        this.scaleY = 1.0;
                        
                        this.wireframe = false;
                        this.opacity = 'full';
                        this.doScale = function () {
                            callback = function () {
                                var tim = clock.getElapsedTime() * 0.7;
                                // pyrimid.scale.x = 1 + Math.sin(tim);
                                pyrimid.scale.y = 1 + Math.cos(1.5798 + tim);
                                //pyrimid.scale.z = 1 + Math.cos(1.5798 + tim) * Math.cos(tim);
                                
                            }
                        };
                    };

                    var slabConfig = new slabConfigData();
                    var slabGui = new dat.GUI();
                    var guiSlab = slabGui.addFolder('Slab ~ Scale');

                    //scale for pyrimid top
                    var pyrimidConfig = new pyrimidConfigData();
                    var pyrimidGui = new dat.GUI();
                    var guiPyrimid = pyrimidGui.addFolder('Pyrimid ~ Scale');

                    //get value of one of the x co-ordinate points - this is for test purposes
                    displayCo = slab.scale.x;   // box1Config.scaleX;

                    //add slab scale control
                    guiSlab.open();
                    
                    //add pryimid scale control
                    guiPyrimid.open();
                    
                    
                    //The following controls the x axis which I'm not working on yet
                    //guiBox1.add(box1Config, 'scaleX', 0, 5).step(.01).onChange(function () {
                    //    slab.scale.x = (box1Config.scaleX);
                    //    //displayCo = slab.scale.x;
                    //    var pp = pyrimid.scale.z ;
                    //    pp = slab.scale.x;
                        
                    //    //pyrimid.scale.z = (slab.scale.z);
                    //});
                    
                    guiPyrimid.add(pyrimidConfig, 'scaleY', 0, 2).onChange(function () {
                        pyrimid.scale.y = (pyrimidConfig.scaleY);
                        
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
                    
                    //guiCone1.add(coneConfig, 'scaleX', 0, 10).onChange(function () {
                    //    pyrimid.scale.x = (cone1Gui.scaleX);
                    //});
                    
                    
                    //Change slab deminisions & move pyrimid in accordance with the altered slab
                    guiSlab.add(slabConfig, 'scaleY', 0.5, 2).onChange(function () {
                        
                       // var tim2 = clock.getElapsedTime() * 2.7;
                        //slab.scale.x = 1 + Math.sin(tim);
                       //var  speed = 1 + Math.cos(2.5798 + tim2);
                        // slab.scale.z = 1 + Math.cos(1.5798 + tim) * Math.cos(tim);
                        slab.scale.y = (slabConfig.scaleY);

                        pyrimid.position.y = (slabConfig.scaleY * slab.position.y) + (slab.position.y + slab.position.y) * 0.5;


                        //Past attempts to manipulate shapes as one
                        
                        //pyrimid.position.y = slab.position.y + slab.geometry.y / 2 + pyrimid.scale.y / 2;// (slab.position.y +20) ;
                        // pyrimid.position.y = (box1Config.scaleY * 7) + (18);
                        //var differnece = pyrimid.position.y - slab.position.y;
                        //pyrimid.position.y = (differnece + slab.position.y);
                        
                        //pyrimid.position.y = slab.scale.y;
                        //slab.scale.y = (pyrimid.scale.y);
                        
                    });
                    
                    //Z co-ordinates for slab - not working on it yet
                    //guiBox1.add(box1Config, 'scaleZ', 0, 10).onChange(function () {
                    //    slab.scale.z = (box1Config.scaleZ);
                        
                    //});
                    
                    
                    function callback() { return; }
                    renderers.push({ renderer: renderer, scene: scene, camera: camera, controls: controls, callback: callback });                  

                }

                function getCoords() {
                    
                    alert(displayCo);

                }


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
           <%-- <form id="fmContronls" runat="server">
                <input id="btnGetValues" type="button" value="Get Values" onclick="getCoords()" />
                <asp:Button runat="server" ID="btnTest" Text="Test Button"  OnClick="btnTest_Click"/>
                
                <textarea id="txtResults" ></textarea>
                
                <asp:TextBox ID="txtResult" runat="server"></asp:TextBox>
                
            </form>--%>
            
        </div>
    </body>
</html>
