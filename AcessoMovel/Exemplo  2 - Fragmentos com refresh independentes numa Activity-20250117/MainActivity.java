package com.example.myapplication;

import android.os.Bundle;
import androidx.appcompat.app.AppCompatActivity;
import androidx.fragment.app.Fragment;
import androidx.fragment.app.FragmentTransaction;

public class MainActivity extends AppCompatActivity {

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);

        // Inicializa os fragmentos
        replaceFragment(new FragmentLeft(), R.id.fragmentContainerLeft);
        replaceFragment(new FragmentRight(), R.id.fragmentContainerRight);

        // Botão para atualizar o Fragmento Esquerdo
        findViewById(R.id.btnRefreshLeft).setOnClickListener(view ->
                replaceFragment(new FragmentLeft(), R.id.fragmentContainerLeft)
        );

        // Botão para atualizar o Fragmento Direito
        findViewById(R.id.btnRefreshRight).setOnClickListener(view ->
                replaceFragment(new FragmentRight(), R.id.fragmentContainerRight)
        );
    }

    private void replaceFragment(Fragment fragment, int containerId) {
        FragmentTransaction transaction = getSupportFragmentManager().beginTransaction();
        transaction.replace(containerId, fragment);
        transaction.commit();
    }
}