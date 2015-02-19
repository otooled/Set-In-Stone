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
    <script src="Scripts/dat.gui.min.js"></script>--%><%: Styles.Render("~/Content/bootstrap.css") %>    <%: Scripts.Render("~/bundles/jQuery") %>
   
    <script>
        var renderer, scene, camera, controls, stats;
        var light, geometry, material, mesh, np;
        var clock = new THREE.Clock();
        var renderers = [];

        //Height of pyramid
        var Pyramid_Height = null;
        
        //This will act as width & length as slab
        var Slab_Width = null;

        var Slab_Height = null;
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
                        //this.scaleX = 1.0;
                        this.scaleY = 1.0;
                        //this.scaleZ = 1.0;
                        
                        this.wireframe = false;
                        this.opacity = 'full';
                        this.doScale = function () {
                            callback = function () {
                                var tim = clock.getElapsedTime() * 0.7;
                                //pyrimid.scale.x = 1 + Math.sin(tim);
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
                        
                        //Put Y scale value in global variable
                        Slab_Height = slab.scale.y;
                        
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
                    guiSlab.add(slabConfig, 'scaleX', 0.5, 1.5).step(.01).onChange(function () {
                        slab.scale.x = (slabConfig.scaleX);
                        slab.scale.z = (slabConfig.scaleX);
                        pyrimid.scale.x = (slabConfig.scaleX);
                        pyrimid.scale.z = (slabConfig.scaleX);
                        //pyrimid.scale.z = (slab.scale.z);
                        
                        //Puts value of X co-ordinate in globally declared variable
                        Slab_Width = slab.scale.x;
                    });
                    
                    //Z co-ordinates for slab - not working on it yet

                    //guiSlab.add(slabConfig, 'scaleZ', 0, 1.5).onChange(function () {
                    //    slab.scale.z = (slabConfig.scaleZ);

                    //});
                    
                    //add pryimid scale control
                    guiPyrimid.open();
                    
                    //Pryamid scale Y co-ordinate
                    guiPyrimid.add(pyrimidConfig, 'scaleY', 0, 2).onChange(function () {
                        pyrimid.scale.y = (pyrimidConfig.scaleY);

                        //Puts value of Y co-ordinate in globally declared variable
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
                    
                    //X & Z co-ordinates of pryamid
                    
                    //guiPyrimid.add(pyrimidConfig, 'scaleX', 0, 1.5).onChange(function () {
                    //    pyrimid.scale.x = (pyrimidConfig.scaleX);
                    //    pyrimid.scale.z = (pyrimidConfig.scaleX);
                    //    slab.scale.x = (pyrimidConfig.scaleX);
                    //    slab.scale.z = (pyrimidConfig.scaleX);

                        
                    //});
                  
                    
                    function callback() { return; }
                    renderers.push({ renderer: renderer, scene: scene, camera: camera, controls: controls, callback: callback });

                }

                //Function to send Y co-ordinate of pryamid to code behind
                function DisplaySlabWidth() {
                    var GetSlabWidth = Slab_Width;
                    document.getElementById('<%= SlabWidth.ClientID %>').value = GetSlabWidth;
                }

                function DisplayPryHeight() {
                    var GetPryHeight = Pyramid_Height;
                    document.getElementById('<%= PryHeight.ClientID %>').value = GetPryHeight;
                }

                function DisplaySlabHeight() {
                    var GetSlabHeight = Slab_Height;
                    document.getElementById('<%= SlabHeight.ClientID %>').value = GetSlabHeight;
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
                <%--Start of Ajax commands--%>
                <asp:ScriptManager ID="MainScriptManager" runat="server" />

                <%-- Connection to test database--%>
                <%--This div gets updated using Ajax--%>
                <div align="center">
                    <asp:UpdatePanel runat="server" ID="UpdatePanel" UpdateMode="Conditional">
                        <Triggers>
                            <asp:AsyncPostBackTrigger ControlID="btnCalculate" />
                        </Triggers>
                        <ContentTemplate>
                           
                            <asp:DropDownList ID="ddlStoneType"  runat="server" DataSourceID="SetInStone" DataTextField="StoneType" DataValueField="CostPerSqMetre"
                                class="btn btn-info dropdown-toggle" data-toggle="dropdown">
                            </asp:DropDownList>
                            <asp:DropDownList ID="ddlStoneSlab" runat="server" DataSourceID="SetInStone_Slab" DataTextField="SlabSize" DataValueField="SlabCost"
                                class="btn btn-info dropdown-toggle">
                            </asp:DropDownList>
                            <asp:SqlDataSource ID="SetInStone_Slab" runat="server" ConnectionString="<%$ ConnectionStrings:SetInStoneConnectionString %>" SelectCommand="SELECT * FROM [Slab_Table]"></asp:SqlDataSource>
                            <asp:SqlDataSource ID="SetInStone" runat="server" ConnectionString="<%$ ConnectionStrings:SetInStoneConnectionString %>" SelectCommand="SELECT * FROM [Stone Type]"></asp:SqlDataSource>
                           
                            <br />

                            <asp:Button class="btn btn-success" runat="server" ID="btnCalculate" Text="Calculate Cost" OnClick="btnCalculate_Click"  />
                            <br />
                            

<%--                         Hidden fields for slab and pryamid measurements--%>
                            <asp:HiddenField ID="SlabWidth" runat="server" />
                            <asp:HiddenField ID="PryHeight" runat="server"/>
                            <asp:HiddenField ID="SlabHeight" runat="server"/>

                            <asp:TextBox runat="server" ID="txtPryHeight"></asp:TextBox>
                            <asp:Label runat="server" ID="lblCalculateAnswer"></asp:Label>
                           <div id="ProvisionalCosts" align="right">
                        <label>Are these measurements correct?</label>
                        <asp:Button ID="BtnProvisionalCost" runat="server" Text="Yes" OnClientClick="DisplayPryHeight(); DisplaySlabHeight();   " OnClick="BtnProvisionalCost_Click"  />
                       <br/>
                               <asp:Label Visible="False" ID="lblTotalHeight" runat="server">Total Height (Slab and Pryamid)</asp:Label>
<%--                         <label hidden="true" id="lblTotalHeight">Total Height (Slab and Pryamid)</label>--%>
                        <asp:Label ID="lblDisplyHTotal" runat="server"></asp:Label>
                    </div>
                        </ContentTemplate>
                    </asp:UpdatePanel>
                    
                </div>


            </form>

        </div>


    </body>
</html>
