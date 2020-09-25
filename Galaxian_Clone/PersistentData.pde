import java.io.*;

String persistentStore() {
  return dataPath("persistent.txt");
}

JSONObject getData() {
  JSONObject data = new JSONObject();
  data.setInt("highscore", highScore);
  data.setInt("player1HS", player1HS);
  data.setString("onlineName", onlineName);
  return data;
}

void setData(JSONObject data) {
  highScore = data.getInt("highscore");
  player1HS = data.getInt("player1HS");
  onlineName = data.getString("onlineName");
}

void saveData() {
  JSONObject data = getData();
  saveJSONObject(data, persistentStore());
}

void loadPersistentData() {
  if(!(new File(persistentStore()).exists())) {
    saveData();
  }
  JSONObject data = loadJSONObject(persistentStore());
  setData(data);
}

void stop() {
  saveData();
}

void exit() {
  saveData();
}
