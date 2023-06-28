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
    public User getUser(Long number) throws InterruptedException, ExecutionException {
        Firestore firestore = FirestoreClient.getFirestore();
        ApiFuture<DocumentSnapshot> promise = firestore.collection(COLLECTION_NAME).document(number.toString()).get();
        DocumentSnapshot snapshot = promise.get();
        if(snapshot.exists()){
            User user = snapshot.toObject(User.class);
            return user;
        }
        return null;
    }

    @Override
    public String deleteUser(Long number) {
        Firestore firestore = FirestoreClient.getFirestore();
        ApiFuture<WriteResult> promise = firestore.collection(COLLECTION_NAME).document(number.toString()).delete();
        WriteResult writeResult;
        try {
            writeResult = promise.get();
            return writeResult.getUpdateTime().toString();
        } catch (InterruptedException e) {
            e.printStackTrace();
            return null;
        } catch (ExecutionException e) {
            e.printStackTrace();
            return null;
        }
    }
}
