package org.example;
import com.intuit.karate.junit5.Karate;

public class Runner {
    @Karate.Test
    Karate testAll() {
        return Karate.run("classpath:features").relativeTo(getClass());
    }
    @Karate.Test
    Karate testHappyPathAuth(){
        return Karate.run("classpath:features").tags("@HappyPath","@auth").relativeTo(getClass());
    }
    @Karate.Test
    Karate testHappyPathBookingIds(){
        return Karate.run("classpath:features").tags("@HappyPath","@bookingIds").relativeTo(getClass());
    }
}