package demo.web;

import demo.spec.RemoteLogin;
import demo.spec.UserAccess;
import java.io.IOException;
import java.util.HashMap;
import java.util.Map;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

public class ControllerServlet extends HttpServlet {

    public void doGet(HttpServletRequest request, HttpServletResponse response)
        throws IOException, ServletException {
        process(request, response);
    }

    public void doPost(HttpServletRequest request, HttpServletResponse response)
        throws IOException, ServletException {
        process(request, response);
    }

    protected void process(HttpServletRequest request, HttpServletResponse response)
        throws IOException, ServletException {
        
        String view = perform_action(request);
        forwardRequest(request, response, view);
    }

    protected String perform_action(HttpServletRequest request)
        throws IOException, ServletException {
        String serv_path = request.getServletPath();
        HttpSession session = request.getSession();

        if (serv_path.equals("/login.do")) {
            if(getRemoteLogin()==null){
                return "/error-no-user_access.html";
            }else{
                String user = (String) request.getParameter("user");
                String password = (String) request.getParameter("password");
                Map<String, String> userCredentials = new HashMap();
                userCredentials.put("Sergi", "1105");
                userCredentials.put("Garazi", "12h");
                userCredentials.put("test","test");
                if(userCredentials.containsKey(user)){
                    if(userCredentials.containsValue(password)){
                        UserAccess userAccess = getRemoteLogin().connect(user, password);
                        session.setAttribute("useraccess", userAccess);
                        return "/view/wallview.jsp";
                    }
                }
                return "/error-no-user_access.html";
            }
        } 
        
        else if (serv_path.equals("/put.do")) {
            if(getRemoteLogin()==null){
                return "/error-not-loggedin.html";
            }else{
                UserAccess userAccess = (UserAccess) session.getAttribute("useraccess");
                String user = userAccess.getUser();
                String message = (String) request.getParameter("msg");
                userAccess.put(message);
                session.setAttribute("msg", message);
                //return "/wallview"; 
                return "/view/wallview.jsp";
            }
        } 
        
        else if (serv_path.equals("/refresh.do")) {
            if(getRemoteLogin()==null){
                return "/error-not-loggedin.html";
            }else{
                UserAccess userAccess = (UserAccess) session.getAttribute("useraccess");
                String message = (String) userAccess.getLast().getContent();
                String user = (String) userAccess.getLast().getOwner();
                session.setAttribute("msg", message);
                session.setAttribute("user", user);
                //return "/wallview";
                return "/view/wallview.jsp";
            }
        } 
        
        else if (serv_path.equals("/logout.do")) {
            UserAccess userAccess = (UserAccess) session.getAttribute("useraccess");
            boolean deleted = userAccess.delete(userAccess.getNumber()-1);
            if (deleted){
                return "/goodbye.html"; 
            }else{
                //return "/wallview"; 
                return "/view/wallview.jsp";
            }
            
        } 
        
        else if (serv_path.equals("/delete.do")) {
            if(getRemoteLogin()==null){
                return "/error-not-loggedin.html";
            }else{
                int index = 0;
                String id = (String) request.getParameter("index");
                if(id !=null){
                    index = Integer.parseInt(id);  
                    UserAccess userAccess = (UserAccess) session.getAttribute("useraccess");
                    Boolean b = userAccess.delete(index);
                }
                // "/wallview";
                return "/view/wallview.jsp";
            }
        }
        
        else {
            return "/error-bad-action.html";
        }
    }

    public RemoteLogin getRemoteLogin() {
        return (RemoteLogin) getServletContext().getAttribute("remoteLogin");
    }
    public void forwardRequest(HttpServletRequest request, HttpServletResponse response, String view) 
            throws ServletException, IOException {
        RequestDispatcher dispatcher = getServletContext().getRequestDispatcher(view);
        if (dispatcher == null) {
            throw new ServletException("No dispatcher for view path '"+view+"'");
        }
        dispatcher.forward(request,response);
    }
}


