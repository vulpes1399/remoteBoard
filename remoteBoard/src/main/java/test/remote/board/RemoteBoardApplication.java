package test.remote.board;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.boot.builder.SpringApplicationBuilder;
import org.springframework.web.bind.annotation.RequestMapping;

@SpringBootApplication
public class RemoteBoardApplication {
	
	
	protected SpringApplicationBuilder configure(SpringApplicationBuilder application) {
		return application.sources(RemoteBoardApplication.class);
	}

	public static void main(String[] args) {
		SpringApplication.run(RemoteBoardApplication.class, args);
	}
}
