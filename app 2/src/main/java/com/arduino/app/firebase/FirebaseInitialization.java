package com.arduino.app.firebase;

import java.io.FileInputStream;
import java.io.IOException;

import org.springframework.context.annotation.Bean;
import org.springframework.stereotype.Service;

import com.google.auth.oauth2.GoogleCredentials;
import com.google.cloud.firestore.Firestore;
import com.google.firebase.FirebaseApp;
import com.google.firebase.FirebaseOptions;
import com.google.firebase.cloud.FirestoreClient;

import jakarta.annotation.PostConstruct;

@Service
public class FirebaseInitialization{

    @PostConstruct
    public void initialization() {
                try (FileInputStream serviceAccount = new FileInputStream("./serviceAccountKey.json")) {
                    FirebaseOptions options = new FirebaseOptions.Builder()
                    .setCredentials(GoogleCredentials.fromStream(serviceAccount))
                    .setDatabaseUrl("https://arduino-8f2b8-default-rtdb.asia-southeast1.firebasedatabase.app")
                    .build();

                    FirebaseApp.initializeApp(options);
                } catch (IOException e) {
                    e.printStackTrace();
                }
    }
}