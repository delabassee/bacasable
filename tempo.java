    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            PushBuilder push = request.newPushBuilder();
            if (push != null) {
                push.addHeader("Pushed", "from_GF5");
                push.path("payload.jpg").push();
            }
            out.println("<!DOCTYPE html>");
            
        }
    }
