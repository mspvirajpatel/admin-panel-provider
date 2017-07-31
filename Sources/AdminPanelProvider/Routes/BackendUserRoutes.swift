import HTTP
import Vapor

public final class BackendUserRoutes: RouteCollection {
    public let controller: BackendUserController

    public init(renderer: ViewRenderer, env: Environment) {
        controller = BackendUserController(renderer: renderer, env: env)
    }

    public func build(_ builder: RouteBuilder) throws {
        let admin = builder.grouped("admin").grouped(Middlewares.secured)

        admin.get("backend/users", handler: controller.index)

        admin.get("backend/users/create", handler: controller.create)
        admin.post("backend/users/store", handler: controller.store)

        admin.get("backend/users/", BackendUser.parameter, "edit", handler: controller.edit)
        admin.post("backend/users/", BackendUser.parameter, "edit", handler: controller.update)

        admin.get("backend/users/", BackendUser.parameter, "delete", handler: controller.delete)
        admin.get("backend/users/", Int.parameter, "restore", handler: controller.restore)
    }
}

