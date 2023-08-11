package commons;

import javax.mail.Authenticator;
import javax.mail.PasswordAuthentication;

public class Gmail extends Authenticator{

	@Override
	protected PasswordAuthentication getPasswordAuthentication() {
		return new PasswordAuthentication("khplatesemi@gmail.com","rjifhqznqejfvmpy");
		
	}
	
}
