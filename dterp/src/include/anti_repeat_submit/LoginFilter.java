/*
 *this file is part of nseer erp
 *Copyright (C)2006-2010 Nseer(Beijing) Technology co.LTD/http://www.nseer.com 
 *
 *This program is free software; you can redistribute it and/or
 *modify it under the terms of the GNU General Public License
 *as published by the Free Software Foundation; either
 *version 2 of the License, or (at your option) any later version.
 */
package include.anti_repeat_submit;
/**
 * SubmitFilter.java
 *
 *
 * Created: Fri Sep 24 15:04:04 2004
 *
 * @author <a href="mailto:Administrator@ORK"></a>
 * @version 1.0
 */
import javax.servlet.FilterConfig;
import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.ServletResponse;
import javax.servlet.ServletException;
import java.io.IOException;
import javax.servlet.ServletRequest;
import javax.servlet.http.*;

import java.security.*;

public class LoginFilter implements Filter {
  

  public LoginFilter() {

  }

  
  
  /**
   * Describe <code>doFilter</code> method here.
   *
   * @param servletRequest a <code>ServletRequest</code> value
   * @param servletResponse a <code>ServletResponse</code> value
   * @param filterChain a <code>FilterChain</code> value
   * @exception ServletException if an error occurs
   * @exception IOException if an error occurs
   */
  public void doFilter(ServletRequest servletRequest,
                       ServletResponse servletResponse,
                       FilterChain filterChain)
  
  
      throws ServletException, IOException {
     
	  HttpServletRequest request=(HttpServletRequest) servletRequest;
	  HttpServletResponse response=(HttpServletResponse) servletResponse;
	    HttpSession session=request.getSession();
	    String contextPath= request.getContextPath();
	  String path=request.getRequestURI();
	  if(path.startsWith(contextPath+"/main")){
		  
		  Object register_obj=session.getAttribute("realeditorc");
		  if(register_obj==null){
			  response.sendRedirect(contextPath+"/home/login.jsp");
			  return;
		  }
		  
	  }
	  
      filterChain.doFilter(servletRequest,servletResponse);
  }



public void destroy() {
	// TODO Auto-generated method stub
	
}



public void init(FilterConfig arg0) throws ServletException {
	// TODO Auto-generated method stub
	
}
}