package io.opentelemetry.example;

import java.util.concurrent.ThreadLocalRandom;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import redis.clients.jedis.Jedis;
import redis.clients.jedis.JedisPool;
import redis.clients.jedis.exceptions.JedisException;

@Controller
public class FrequencyController {
  private static final JedisPool pool = new JedisPool("localhost", 6379);

  @GetMapping("/frequency")
  @ResponseBody
  public Posts sayHello(@RequestParam(name="tip", required=false, defaultValue="123456789xyz") String tip) {
    Long postsValue = null;
    Jedis jedis = pool.getResource();
    try {
      // Create if none existed.
      jedis.setnx(tip, String.valueOf(ThreadLocalRandom.current().nextLong(1000000000L)));

      // Fetch the value.
      postsValue = Long.valueOf(jedis.get(tip));
    } catch (JedisException e) {
      pool.returnBrokenResource(jedis);
    } finally {
      pool.returnResource(jedis);
    }

    return new Posts(postsValue == null ? -1 : postsValue);
  }

  public static final class Posts {
    private final long posts;

    public Posts(long posts) {
      this.posts = posts;
    }

    public long getPosts() {
      return posts;
    }
  }
}
