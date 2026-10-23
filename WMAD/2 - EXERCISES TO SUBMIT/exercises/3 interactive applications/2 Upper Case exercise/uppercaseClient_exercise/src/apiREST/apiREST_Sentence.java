package apiREST;

import com.google.gson.Gson;
import entity.Sentence;
import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.io.PrintWriter;
import java.net.HttpURLConnection;
import java.net.URL;
import java.util.Arrays;
import java.util.List;

public class apiREST_Sentence {

  public static void create(Sentence sentence) {
    try {
      
      //...

    } catch (Exception e) {
      e.printStackTrace();
    }
  }

  public static List<Sentence> findAll() {
    try {
      
      //...
      return null;

    } catch (Exception ex) {
      ex.printStackTrace();
      return null;
    }
  }

}
