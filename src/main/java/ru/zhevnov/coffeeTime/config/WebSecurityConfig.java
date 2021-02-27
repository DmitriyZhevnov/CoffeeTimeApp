package ru.zhevnov.coffeeTime.config;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.http.HttpMethod;
import org.springframework.security.authentication.dao.DaoAuthenticationProvider;
import org.springframework.security.config.annotation.authentication.builders.AuthenticationManagerBuilder;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.config.annotation.web.configuration.WebSecurityConfigurerAdapter;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.security.web.util.matcher.AntPathRequestMatcher;
import ru.zhevnov.coffeeTime.service.impl.EmployeeService;


@Configuration
@EnableWebSecurity
public class WebSecurityConfig extends WebSecurityConfigurerAdapter {
    @Autowired
    private EmployeeService employeeService;

    @Override
    protected void configure(HttpSecurity http) throws Exception {
        http
                .csrf().disable()
                .authorizeRequests()
                .antMatchers( "login", "/h2/**", "/css/**").permitAll()
                .antMatchers("/shifts/**", "/menu/**", "/closedOrders/date","/employees/**").hasRole("ADMIN")
                .antMatchers("/main/**").hasAnyRole("ADMIN", "USER")
                .antMatchers(HttpMethod.POST, "/login/**").hasAnyRole("ADMIN","USER")
                .antMatchers(HttpMethod.POST, "/closedOrders/**").hasRole("ADMIN")
                .antMatchers(HttpMethod.PATCH, "/closedOrders/**").hasRole("ADMIN")
                .antMatchers(HttpMethod.POST, "/report/**").hasRole("ADMIN")
                .antMatchers(HttpMethod.POST, "/warehouse/**").hasRole("ADMIN")
                .anyRequest()
                .authenticated()
                .and()
                .formLogin().loginPage("/login")
                .loginProcessingUrl("/login").permitAll()
                .defaultSuccessUrl("/login/successEnter", true)
                .usernameParameter("login")
                .passwordParameter("password")
                .failureUrl("/login/failedEnter")
                .and()
                .logout()
                .logoutRequestMatcher(new AntPathRequestMatcher("/logout", "GET"))
                .invalidateHttpSession(true)
                .clearAuthentication(true)
                .deleteCookies("JSESSIONID")
                .logoutSuccessUrl("/login").permitAll();
    }

    @Bean
    public PasswordEncoder passwordEncoder() {
        return new BCryptPasswordEncoder(12);
    }

    @Autowired
    protected void configureGlobal(AuthenticationManagerBuilder auth) throws Exception {
        auth.authenticationProvider(daoAuthenticationProvider());
        auth.userDetailsService(employeeService).passwordEncoder(passwordEncoder());
    }

    @Bean
    protected DaoAuthenticationProvider daoAuthenticationProvider() {
        DaoAuthenticationProvider daoAuthenticationProvider = new DaoAuthenticationProvider();
        daoAuthenticationProvider.setPasswordEncoder(passwordEncoder());
        daoAuthenticationProvider.setUserDetailsService(employeeService);
        return daoAuthenticationProvider;
    }
}

