package com.colin.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class LandingPageController {

	@GetMapping("")
	public String getLandingPage() {
		return "landing-page";
	}

}