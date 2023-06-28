package com.arduino.app.service.serviceImpl;

import java.util.concurrent.CompletableFuture;
import java.util.concurrent.ExecutionException;

import org.springframework.stereotype.Service;

import com.arduino.app.service.WatchService;
import com.google.firebase.database.DataSnapshot;
import com.google.firebase.database.DatabaseError;
import com.google.firebase.database.DatabaseReference;
import com.google.firebase.database.FirebaseDatabase;
import com.google.firebase.database.ValueEventListener;

@Service
public class WatchServiceImpl implements WatchService{

    @Override
    public String getValue(String field) throws InterruptedException, ExecutionException {
        DatabaseReference database = FirebaseDatabase.getInstance().getReference();
        DatabaseReference sensorValue = database.child(field);

        CompletableFuture<String> future = new CompletableFuture<>();

        sensorValue.addListenerForSingleValueEvent(new ValueEventListener() {
            @Override
            public void onDataChange(DataSnapshot dataSnapshot) {
                Float temperatureValue = dataSnapshot.getValue(Float.class);
                System.out.println("Sensor value: " + temperatureValue);
                future.complete(temperatureValue.toString());
            }

            @Override
            public void onCancelled(DatabaseError databaseError) {
                System.out.println("Error retrieving Value: " + databaseError.getMessage());
                future.completeExceptionally(databaseError.toException());
            }
        });

        return future.get();
    }

    @Override
    public <T> void writeValue(String field, T value) {
        DatabaseReference database = FirebaseDatabase.getInstance().getReference();
        DatabaseReference sensorValue = database.child(field);

        sensorValue.setValue(value, new DatabaseReference.CompletionListener() {
            @Override
            public void onComplete(DatabaseError databaseError, DatabaseReference databaseReference) {
                if (databaseError != null) {
                    System.out.println("Error saving value: " + databaseError.getMessage());
                } else {
                    System.out.println("Value saved successfully.");
                }
            }
        });
    }

}
