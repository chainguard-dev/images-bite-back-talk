variable "REPO" {
  default = "amouat/bake"
}

target "base" {
  description = "Basic development build"
  context = "."
  dockerfile = "Dockerfile"
  tags = ["${REPO}:base"]
  output = ["type=docker"]
  pull = true
}

group "default" {
  targets = ["base"]
}

target "cross" {
  description = "Builds multi-platform image using cross compilation"
  inherits = ["base"] 
  dockerfile = "cross.Dockerfile"
  tags = ["${REPO}:multi"]
  platforms = [
    "linux/amd64",
    "linux/arm64",
  ]
}

target "push" {
  description = "Pushes images to registry"
  inherits = ["cross"]
  attest = [
    "type=provenance,mode=max",
    "type=sbom"
  ]
  output = ["type=registry"]
} 
