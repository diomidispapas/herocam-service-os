import Vapor

let drop = Droplet()

drop.group("v1") { v1 in
    v1.get("version") { request in
        return try JSON(node: [
            "version": "1.0"
            ])
    }
    v1.resource("detect_landmark", LandmarkController())
}

drop.run()
