THREE = require('three')

class Screen
  module.exports = this

  constructor: (@$scope, @$element) ->
    @scene = new THREE.Scene()

    @camera = new THREE.PerspectiveCamera 60, window.innerWidth / window.innerHeight, 1, 1000
    @camera.position.x = 40
    @camera.position.y = 0
    @camera.position.z = 10

    @camera.rotation.x = Math.PI / 2
    @camera.rotation.y = Math.PI / 2

    # @controls = new THREE.OrbitControls @camera, @$element[0]
    # @controls.noKeys = true
    # @controls.minPolarAngle = Math.PI * 0.05
    # @controls.maxPolarAngle = Math.PI * 0.45
    # @controls.minDistance = 200
    # @controls.maxDistance = 600

    @renderer = new THREE.WebGLRenderer canvas: @$element[0]
    @renderer.setSize window.innerWidth, window.innerHeight

    grid = new THREE.GridHelper 300, 10
    grid.setColors new THREE.Color(0x666666), new THREE.Color(0x222222)
    @scene.add grid

    axes = new THREE.AxisHelper 20
    @scene.add axes

    @load 'Creature\\Rabbit\\Rabbit.m2.3js', 'Creature\\Rabbit\\RabbitSkin.blp.png', (model) =>
      @scene.add model

    #@load 'Creature\\Illidan\\Illidan.m2.3js', 'Creature\\Illidan\\Illidan.blp.png', (model) =>
    #  @scene.add model

    @load 'Creature\\RAGNAROS\\RAGNAROS.m2.3js', 'Creature\\RAGNAROS\\RAGNAROSSKIN.blp.png', (model) =>
      @scene.add model

    @run()

  run: ->
    @update()
    @animate()
    requestAnimationFrame =>
      @run()

  update: ->
    # @controls.update()

  animate: ->
    @renderer.render @scene, @camera

  load: (path, texturePath, callback) ->
    @loader ||= new THREE.JSONLoader()
    @loader.load "pipeline/#{path}", (geometry) =>
      texture = THREE.ImageUtils.loadTexture "pipeline/#{texturePath}"
      texture.flipY = false
      material = new THREE.MeshBasicMaterial map: texture
      mesh = new THREE.Mesh geometry, material
      callback(mesh)
