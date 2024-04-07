package com.skywhalelab.SpringBootJpa.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;

import com.skywhalelab.SpringBootJpa.dto.BoardPage;
import com.skywhalelab.SpringBootJpa.service.BoardService;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@Controller
public class BoardController {
	
	@Autowired
	BoardService service;
	
	@GetMapping("/index")
	public String index() {
		return "tables";
	}
	
	@GetMapping("/tables")
	public String tables() {
		return "tables";
	}
	
	@GetMapping("/boardSample")
	public String boardSample() {
		return "boardSample";
	}
	
	@GetMapping("/board")
	public String board(HttpServletRequest request, HttpServletResponse response
			, Model model
			, @ModelAttribute BoardPage boardPage) {
		
		boardPage = service.findAll(boardPage);
		
		model.addAttribute("boardPage", boardPage);
		
		return "board";
	}
}
