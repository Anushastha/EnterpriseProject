package com.arduino.app.service.serviceImpl;

import java.util.concurrent.ExecutionException;

import org.springframework.stereotype.Service;

import com.arduino.app.entity.User;
import com.arduino.app.service.UserService;
import com.google.api.core.ApiFuture;
import com.google.cloud.firestore.DocumentSnapshot;
import com.google.cloud.firestore.Firestore;
import com.google.cloud.firestore.WriteResult;
import com.google.firebase.cloud.FirestoreClient;


@Service
public class UserServiceImpl implements UserService{
    
    private static final String COLLECTION_NAME = "users";
    

    public String saveUser(User user) throws InterruptedException, ExecutionException{
        Firestore firestore = FirestoreClient.getFirestore();
        ApiFuture<WriteResult> promise = firestore.collection(COLLECTION_NAME).document(user.getContactNo().toString()).set(user);
        return promise.get().getUpdateTime().toString();
        
    }

    @Override
    public User getUser(String name) throws InterruptedException, ExecutionException {
        Firestore firestore = FirestoreClient.getFirestore();
        ApiFuture<DocumentSnapshot> promise = firestore.collection(COLLECTION_NAME).document(name).get();
        DocumentSnapshot snapshot = promise.get();
        if(snapshot.exists()){
            User product = snapshot.toObject(User.class);
            return product;
        }
        return null;
    }
}
