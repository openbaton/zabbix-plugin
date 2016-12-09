package org.openbaton.monitoring.agent.test;

import org.junit.After;
import org.junit.Before;
import org.junit.Ignore;
import org.junit.Test;
import org.openbaton.monitoring.agent.Starter;

import java.io.IOException;

/**
 * Created by pku on 09.12.16.
 */
public class StarterTest {
  private Starter starter;

  @Before
  public void init() throws IOException {
    starter = new Starter();
  }

  @Test
  @Ignore
  public void startAndStopStarterTest() {
    starter.main(new String[]{""});
    starter.main(new String[]{"zabbix", "localhost","5672","1"});
  }

  @Test(expected=ArrayIndexOutOfBoundsException.class)
  public void wrongParameterCountStarterTest() {
    starter.main(new String[]{"garbage here", "and here"});
  }

  @After
  public void destroy() throws InterruptedException {
  }
}
