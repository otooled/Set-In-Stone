<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Home.aspx.cs" Inherits="SetInStone.WebForm1" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <link href="HomeSS.css" rel="stylesheet" />
    <meta content='IE=EmulateIE7' http-equiv='X-UA-Compatible' />
    <meta content='width=1100' name='viewport' />
    <meta content='text/html; charset=UTF-8' http-equiv='Content-Type' />
    
    <script src="Scripts/three.min.js"></script>
    <script src="Scripts/TrackballControls.js"></script>
    <script src="Scripts/Detector.js"></script>
    <script src="Scripts/stats.min.js"></script>
    <script src="Scripts/dat.gui.min.js"></script>
   
    <script>
        var renderer, scene, camera, controls, stats;
        var light, geometry, material, mesh;
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


                    geometry = new THREE.CubeGeometry(50, 40, 200);

                    //color of slab
                    color = 0x969696;

                    //create the pyrimid shape
                    pyrimid = new THREE.CylinderGeometry(0, 50, 30, 4, 1);

                    material = new THREE.MeshPhongMaterial({ color: color, ambient: color, transparent: true });

                    box1 = new THREE.Mesh(geometry, material);
                    box1.castShadow = true;
                    box1.position.set(0, 0, 0);

                    //add the pyrimid (now called cone) to the scene
                    cone = new THREE.Mesh(pyrimid, material);
                    cone.position.set(50, 40, 20);
                    //cone.geometry.v

                    scene.add(box1);
                    scene.add(cone);

                    //funtion to manipulated pryimed shape
                    var coneConfigData = function () {
                        this.scaleY = 1.0;
                        this.wireframe = false;
                        this.opacity = 'full';
                        this.doScale = function () {
                            callback = function () {
                                var tim = clock.getElapsedTime() * 0.7;
                                cone.scale.y = 1 + Math.cos(1.5798 + tim);
                                //cone.position.z = box1.scale.z + cone.scale.y;
                            }
                        };
                    };

                    var box1ConfigData = function () {
                        this.scaleX = 1.0;
                        this.scaleY = 1.0;
                        this.scaleZ = 1.0;
                        this.wireframe = false;
                        this.opacity = 'full';
                        this.doScale = function () {
                            callback = function () {
                                var tim = clock.getElapsedTime() * 0.7;
                                box1.scale.x = 1 + Math.sin(tim);
                                box1.scale.y = 1 + Math.cos(1.5798 + tim);
                                box1.scale.z = 1 + Math.cos(1.5798 + tim) * Math.cos(tim);
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

                    //get value of one of the points
                    displayCo = box1.scale.x;   // box1Config.scaleX;

                    guiBox1.open();
                    guiBox1.add(box1Config, 'scaleX', 0, 5).step(.01).onChange(function () {
                        box1.scale.x = (box1Config.scaleX);
                        displayCo = box1.scale.x;
                    });

                    //add pryimid for scale controls
                    guiCone1.open();
                    guiCone1.add(coneConfig, 'scaleY', 0, 5).step(.01).onChange(function () {
                        cone.scale.y = (coneConfig.scaleY);
                        //box1.scale.z = box1.scale.z + 1;
                        cone.position.y = (box1.scale.y * 40 / 2) + (cone.scale.y * 50 / 2);
                        //box1.scale.y += 0.05;
                        //cone.scale.y += 0.01;
                        //alert(cone.position.x);
                        //alert(box1.scale.y);
                        //alert(cone.scale.x);
                        //alert(cone.scale.y);
                        //alert(cone.scale.z);
                        //alert(coneConfig.scaleY);
                    });

                    guiBox1.add(box1Config, 'scaleY', 0, 10).onChange(function () {
                        box1.scale.y = (box1Config.scaleY);
                    });

                    guiBox1.add(box1Config, 'scaleZ', 0, 10).onChange(function () {
                        box1.scale.z = (box1Config.scaleZ);
                    });

                    function callback() { return; }
                    renderers.push({ renderer: renderer, scene: scene, camera: camera, controls: controls, callback: callback });

                }

                function getCoords() {
                    alert('test');
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
                <textarea id="txtResults" ></textarea>
                
            </form>
            
        </div>
    </body>
</html>
