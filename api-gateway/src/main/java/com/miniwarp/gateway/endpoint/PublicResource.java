package com.miniwarp.gateway.endpoint;

import com.miniwarp.user.endpoint.UserResource;

import javax.inject.Inject;
import javax.ws.rs.Path;

@Path("/api/public")
public class PublicResource {
    @Inject
    UserResource userResource;

    public UserResource getUserResource() {
        return userResource;
    }
}
