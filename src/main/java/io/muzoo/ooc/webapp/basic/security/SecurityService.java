package io.muzoo.ooc.webapp.basic.security;

import io.muzoo.ooc.webapp.basic.model.User;
import lombok.Setter;
import org.mindrot.jbcrypt.BCrypt;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.util.Objects;

public class SecurityService {

    private UserService userService;

    public void setUserService(UserService userService) {
        this.userService = userService;
    }

    public String getCurrentUsername(HttpServletRequest request) {
        HttpSession session = request.getSession();
        Object usernameObject = session.getAttribute("username");
        return (String) usernameObject;
    }

    public boolean isAuthorized(HttpServletRequest request) {
        String username = (String) request.getSession()
                .getAttribute("username");
        // do checking using user from the database
        return (username != null && userService.findByUsername(username) != null);
    }

    public boolean authenticate(String username, String password, HttpServletRequest request) {
        User user = userService.findByUsername(username);
        if (user != null && BCrypt.checkpw(password, user.getPassword())) {
            request.getSession().setAttribute("username", username);
            return true;
        }
        return false;
    }

    public void logout(HttpServletRequest request) {
        HttpSession session = request.getSession();
        session.removeAttribute("username");
        session.invalidate();
    }

    public boolean login(HttpServletRequest request) {
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        User user = userService.findByUsername(username);
        if (user != null && Objects.equals(user.getPassword(), password)) {
            HttpSession session = request.getSession();
            session.setAttribute("username", username);
            return true;
        } else {
            return false;
        }

    }
}


//package io.muzoo.ooc.webapp.basic.security;
//
//import javax.servlet.http.HttpServletRequest;
//import javax.servlet.http.HttpSession;
//import java.util.Objects;
//
//public class SecurityService {
//
//    private UserService userService;
//
//    public void setUserService(UserService userService) {
//        this.userService = userService;
//    }
//
//    public String getCurrentUsername(HttpServletRequest request) {
//        HttpSession session = request.getSession();
//        Object usernameObject = session.getAttribute("username");
//        return (String) usernameObject;
//    }
//
//    public boolean isAuthorized(HttpServletRequest request) {
//        String username = getCurrentUsername(request);
//        return userService.checkIfUserExists(username);
//    }
//
//    public void logout(HttpServletRequest request) {
//        HttpSession session = request.getSession();
//        session.removeAttribute("username");
//        session.invalidate();
//    }
//
//    public boolean login(HttpServletRequest request) {
//        String username = request.getParameter("username");
//        String password = request.getParameter("password");
//        User user = userService.findByUsername(username);
//        if (user != null && Objects.equals(user.getPassword(), password)) {
//            HttpSession session = request.getSession();
//            session.setAttribute("username", username);
//            return true;
//        } else {
//            return false;
//        }
//
//    }
//}
