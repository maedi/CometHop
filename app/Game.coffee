if Meteor.is_client 

  Meteor.startup ->
  
    # 1. SCENE
    WIDTH = window.innerWidth
    HEIGHT = window.innerHeight
    VIEW_ANGLE = 45
    ASPECT = WIDTH / HEIGHT
    NEAR = 0.1
    FAR = 10000
  
    window.scene = new THREE.Scene()
      
    window.renderer = new THREE.WebGLRenderer({antialias: true})
    window.renderer.setSize WIDTH, HEIGHT
  
    viewport = document.getElementById('viewport')
    document.getElementById('viewport').appendChild(renderer.domElement)
    #document.body.appendChild window.renderer.domElement

    
    # GRID

    plane = new THREE.PlaneGeometry(50, 50, 50, 50) # height, width, segment height, segment width
    meshCanvas = new THREE.Mesh(plane, new THREE.MeshBasicMaterial( { color: 0x2d2d2d, wireframe: true } ))
    #meshCanvas.rotation.x = -150 * Math.PI / 180
    #meshCanvas.rotation.y = 135 * Math.PI / 180
    meshCanvas.scale.z = 250
    meshCanvas.scale.y = meshCanvas.scale.z
    meshCanvas.scale.x = meshCanvas.scale.y
    window.scene.add meshCanvas


    # SPACE BACKGROUND
  
    spaceImage = new Image()
    spaceImage.src = "textures/grass.gif"
    spaceImage.onload = ->
    
    #grass = THREE.ImageUtils.loadTexture("http://192.168.1.12/~maedi/CometHop/textures/grass.gif")
    #grass.wrapT = grass.wrapS = THREE.RepeatWrapping
    plane = new THREE.PlaneGeometry(50, 50, 50, 50) # height, width, segment height, segment width
    
    meshCanvas = new THREE.Mesh(plane, new THREE.MeshBasicMaterial( { color: 0x2d2d2d, wireframe: true } ))
    #meshCanvas.rotation.x = -150 * Math.PI / 180
    #meshCanvas.rotation.y = 135 * Math.PI / 180
    meshCanvas.scale.z = 250
    meshCanvas.scale.y = meshCanvas.scale.z
    meshCanvas.scale.x = meshCanvas.scale.y
    window.scene.add meshCanvas



    
  
    # 3. PLAYER AND CONTROLS
    
    player = new THREE.Object3D()
  
  
    #loader = new THREE.JSONLoader()
    #callbackDice = function( geometry ) { createMesh(geometry) }
    #loader.load("models/three/ship.json", callbackDice )
  
    window.player = new THREE.JSONLoader().load "models/three/ship.json", (geometry) ->
      window.mesh = new THREE.Mesh(geometry, new THREE.MeshLambertMaterial( { color: 0xFFFFFF } ))
      
      window.mesh.scale.x = 10
      window.mesh.scale.y = 10
      window.mesh.scale.z = 10
      
      scene.add window.mesh
  
      window.controls = new THREE.FlyControls(window.mesh, viewport)
      window.controls.movementSpeed = 3
      window.controls.rollSpeed = 0.05
      window.controls.autoForward = false
      window.controls.dragToLook = true
    
      # CONTROLS
      
      #$('body').keydown (e) ->
      #  arrow = { left: 37, up: 38, right: 39, down: 40 }
      #
      #  switch e.which
      #    when arrow.left then window.mesh.position.x -= 15 # and player.position.camera.x -= 1 and console.log 'left'
      #    when arrow.right then window.mesh.position.x += 15
      #    when arrow.up then window.mesh.position.z -= 15 # and player.position.camera.x -= 1 and console.log 'left'
      #    when arrow.down then window.mesh.position.z += 15
      
      #keyboard = new THREEx.KeyboardState()
      #if keyboard.pressed("A")
      #  alert('asdf')
    
    
    # 4. MATERIALS
    cometTexture = THREE.ImageUtils.loadTexture("textures/comet.jpg")
    cometTexture.wrapS = cometTexture.wrapT = THREE.ClampToEdgeWrapping
    cometTexture.needsUpdate = true
    cometMaterial = new THREE.MeshLambertMaterial( { map: cometTexture } )

    earthTexture = THREE.ImageUtils.loadTexture("textures/earth.jpg")
    earthTexture.wrapS = earthTexture.wrapT = THREE.ClampToEdgeWrapping
    earthTexture.needsUpdate = true
    earthMaterial = new THREE.MeshLambertMaterial( { map: earthTexture } )
    
    
    # 5. MAKING A MESH
    radius = 120
    segments = 16
    rings = 16
  
    window.sphere = new THREE.Mesh(new THREE.SphereGeometry(radius, segments, rings), earthMaterial)
    window.sphere.position.z = -200
    window.sphere.position.y = -120
    window.scene.add window.sphere
  
    window.sphere2 = new THREE.Mesh(new THREE.SphereGeometry(50, 12, 12), cometMaterial)
    window.sphere2.position.x = -400
    window.sphere2.position.y = -55
    window.sphere2.position.z = 0
    window.scene.add window.sphere2
  
    window.sphere3 = new THREE.Mesh(new THREE.SphereGeometry(50, 12, 12), cometMaterial)
    window.sphere3.position.x = -300
    window.sphere3.position.y = -55
    window.sphere3.position.z = 0
    window.scene.add window.sphere3
  
    window.sphere4 = new THREE.Mesh(new THREE.SphereGeometry(50, 12, 12), cometMaterial)
    window.sphere4.position.x = -500
    window.sphere4.position.y = -55
    window.sphere4.position.z = 2000
    window.scene.add window.sphere4
  
    # CAMERA
    
    window.camera = new THREE.PerspectiveCamera(VIEW_ANGLE, ASPECT, NEAR, FAR)
    window.camera.position.y = 700
    window.scene.add window.camera
    
    # LIGHTS
    
    # main light
    pointLight = new THREE.PointLight(0xFFFFFF)
    pointLight.position.x = 10
    pointLight.position.y = 100
    pointLight.position.z = 300
    window.scene.add pointLight
    
    # ambient lighting
    ambientLight = new THREE.AmbientLight(0x333333)
    window.scene.add ambientLight
    
    # RENDER LOOP + ANIMATE
  
    textureImg = new Image()
    textureImg.src = "textures/comet.jpg"
    textureImg.onload = ->
      animate()
  
    # STATS
    #stats = new Stats();
    #stats.domElement.style.position = 'absolute';
    #stats.domElement.style.top = '0px';
    #stats.domElement.style.zIndex = 100;
    #document.body.appendChild( stats.domElement );

    #rotateAroundObjectAxis = (object, axis, radians) ->
    #  rotObjectMatrix = new THREE.Matrix4()
    #  rotObjectMatrix.makeRotationAxis(axis.normalize(), radians)
    #  object.matrix.multiplySelf(rotObjectMatrix) # post-multiply
    #  object.rotation.getRotationFromMatrix(object.matrix, object.scale)      
      
    animate = ->
    
      #keyboard = new THREEx.KeyboardState()
      #if keyboard.pressed("A")
      #  alert('asdf')
    
      #window.camera.position.x -= 1
      #console.log 'left render'
    
      window.sphere.rotation.y += 0.0008
      window.sphere2.rotation.y -= 0.01
    
      # note: three.js includes requestAnimationFrame shim
      requestAnimationFrame( animate )
      # currently object not created in time for first few frames or so
      
      # Position camera on Player
      if window.mesh != undefined
        window.camera.position.x = window.mesh.position.x
        window.camera.position.z = window.mesh.position.z + 450
        window.camera.lookAt(window.mesh.position)
      
        #xAxis = new THREE.Vector3(1,0,0)
        #rotateAroundObjectAxis(window.sphere, xAxis, Math.PI / 180)
        #console.log window.mesh.matrixWorld.getPosition()
        #console.log window.mesh.position.z
        
        window.controls.update(1)
    
    
      window.renderer.render window.scene, window.camera
      #render()