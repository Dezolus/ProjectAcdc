package com.javarush.sopyraev;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

@WebServlet("/start")
public class Quest extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        response.setContentType("text/html; charset=UTF-8");
        response.setCharacterEncoding("UTF-8");
        if (session.getAttribute("visited") == null) {
            session.setAttribute("visited", false);
            session.setAttribute("foundWeapon", false);
            session.setAttribute("foundWeaponCargoSlums", false);
            session.setAttribute("foundWeaponCargoApartments", false);
            session.setAttribute("omelliTalk", false);
            session.setAttribute("omelliTalkFinal", false);
            session.setAttribute("stunnedOmelli", false);
            session.setAttribute("bribed", false);
            session.setAttribute("location", Location.STREET);
            session.setAttribute("win", false);
        }
        getServletContext().getRequestDispatcher("/WEB-INF/sopyraev/queststart.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession();
        String action = req.getParameter("action");
        if (action != null) {
            switch (action) {
                case "goToSlums" ->
                    session.setAttribute("location", Location.SLUMS);

                case "takeCargo" ->
                    session.setAttribute("foundWeaponCargoSlums", true);

                case "goToApartments" ->
                    session.setAttribute("location", Location.APARTMENTS);

                case "takeBribe" -> {
                    session.setAttribute("bribed", true);
                    session.setAttribute("win", true);
                }
                case "stunOmelli" -> {
                    session.setAttribute("stunnedOmelli", true);
                    session.setAttribute("win", true);
                }
                case "takeWeaponCargoAndDrugs" -> {
                    session.setAttribute("foundWeaponCargoApartments", true);
                    session.setAttribute("foundDrugs", true);
                }
                case "goToMeeting" -> {
                    session.setAttribute("location", Location.BACKSTREET);
                    session.setAttribute("omelliTalk", true);
                }
                case "weaponSearch" ->
                    session.setAttribute("foundWeapon", true);

                case "goToJenny" -> {
                    session.setAttribute("visited", true);
                    if ((boolean) session.getAttribute("foundWeaponCargoApartments") && (boolean) session.getAttribute("foundWeaponCargoSlums") && (boolean) session.getAttribute("foundWeapon")) {
                        session.setAttribute("omelliTalkFinal", true);
                    }
                    session.setAttribute("location", Location.STREET);
                }
                default ->
                    session.setAttribute("location", Location.STREET);

            }
        }
        resp.sendRedirect("/start");
    }

}
