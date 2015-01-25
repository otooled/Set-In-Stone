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

                    //slab is called box1
                    box1 = new THREE.Mesh(geometry, material);
                    box1.castShadow = true;
                    box1.position.set(0, 12 , 0);
                    
                    //create the pyrimid shape
                    pyrimid = new THREE.CylinderGeometry(0, 70, 10, 4, 1);

                    //add the pyrimid (now called cone) to the scene
                    cone = new THREE.Mesh(pyrimid, material);
                    cone.position.set(0, 24.5, 0);
                    cone.rotation.y = Math.PI * 45 / 180;

                    scene.add(box1);
                    scene.add(cone);

                   

                    //funtion to manipulated slab shape
                    var box1ConfigData = function () {
                        //this.scaleX = 1.0;
                        this.scaleY = 1.0;
                        //this.scaleZ = 1.0;
                        this.wireframe = false;
                        this.opacity = 'full';
                        this.doScale = function () {
                            callback = function () {
                                var tim = clock.getElapsedTime() * 0.7;
                                //box1.scale.x = 1 + Math.sin(tim);
                                box1.scale.y = 1 + Math.cos(1.5798 + tim);
                                //box1.scale.z = 1 + Math.cos(1.5798 + tim) * Math.cos(tim);
                            }
                        };
                    };
                    
                    //funtion to manipulated pryimed shape
                    var coneConfigData = function () {
                        //this.scaleX = 1.0;
                        this.scaleY = 1.0;
                        
                        this.wireframe = false;
                        this.opacity = 'full';
                        this.doScale = function () {
                            callback = function () {
                                var tim = clock.getElapsedTime() * 0.7;
                               // cone.scale.x = 1 + Math.sin(tim);
                                cone.scale.y = 1 + Math.cos(1.5798 + tim);
                                //cone.scale.z = 1 + Math.cos(1.5798 + tim) * Math.cos(tim);


                                //cone.position.z = box1.scale.z + cone.scale.y;
                            }
                        };
                    };

                    var box1Config = new box1ConfigData();
                    var box1Gui = new dat.GUI();
                    var guiBox1 = box1Gui.addFolder('Slab ~ Scale');

                    //scale for pyrimid top
                    var coneConfig = new coneConfigData();
                    var cone1Gui = new dat.GUI();
                    var guiCone1 = cone1Gui.addFolder('Pyrimid ~ Scale');
                    
                    ////scale for pyrimid top
                    //var coneConfig2 = new coneConfigData();
                    //var cone2Gui = new dat.GUI();
                    //var guiCone2 = cone2Gui.addFolder('Pyrimid ~ Scale');

                    //get value of one of the points
                    displayCo = box1.scale.x;   // box1Config.scaleX;

                    guiBox1.open();
                    //guiBox1.add(box1Config, 'scaleX', 0, 5).step(.01).onChange(function () {
                    //    box1.scale.x = (box1Config.scaleX);
                    //    //displayCo = box1.scale.x;
                    //    var pp = cone.scale.z ;
                    //    pp = box1.scale.x;
                        
                    //    //cone.scale.z = (box1.scale.z);
                    //});

                    //add pryimid for scale controls
                    guiCone1.open();
                    guiCone1.add(coneConfig, 'scaleY', 0, 2).onChange(function () {
                        cone.scale.y = (coneConfig.scaleY);
                        //box1.scale.z = box1.scale.z + 1;
                        
                        //var slabposition = box1.position.y ;

                        //box1.position.y = (coneConfig.scaleY + cone.position.y) + (cone.position.y + cone.position.y)*0.5;
                        //cone.position.y = coneConfig.scaleY + 12;
                        
                        //cone.position.y = (box1Config.scaleY * box1.position.y) + (box1.position.y + box1.position.y)*0.5;
                        //cone.position.y = (coneConfig.scaleY*7)+18.5;
                        // .step(.01)
                    });
                    
                    //add pryimid for scale controls
                    //guiCone1.add(coneConfig, 'scaleX', 0, 10).onChange(function () {
                    //    cone.scale.x = (cone1Gui.scaleX);
                    //});
                    
                    //Change slab deminisions
                    guiBox1.add(box1Config, 'scaleY', 0.5, 2).onChange(function () {
                        
                       // var tim2 = clock.getElapsedTime() * 2.7;
                        //box1.scale.x = 1 + Math.sin(tim);
                       //var  speed = 1 + Math.cos(2.5798 + tim2);
                        // box1.scale.z = 1 + Math.cos(1.5798 + tim) * Math.cos(tim);
                        box1.scale.y = (box1Config.scaleY);
                        //cone.position.y = box1.position.y + box1.geometry.y / 2 + cone.scale.y / 2;// (box1.position.y +20) ;

                        cone.position.y = (box1Config.scaleY * box1.position.y) + (box1.position.y + box1.position.y) * 0.5;




                       // cone.position.y = (box1Config.scaleY * 7) + (18);
                        //cone.position.y = box1Config.scaleY;
                        
                        //cone.position.y = box1.scale.y;
                        //box1.scale.y = (cone.scale.y);
                        
                        
                    });

                    //guiBox1.add(box1Config, 'scaleZ', 0, 10).onChange(function () {
                    //    box1.scale.z = (box1Config.scaleZ);
                        
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
            <form id="fmContronls" runat="server">
                <input id="btnGetValues" type="button" value="Get Values" onclick="getCoords()" />
                <asp:Button runat="server" ID="btnTest" Text="Test Button"  OnClick="btnTest_Click"/>
                
                <textarea id="txtResults" ></textarea>
                
                <asp:TextBox ID="txtResult" runat="server"></asp:TextBox>
                
            </form>
            
        </div>
    </body>
</html>
