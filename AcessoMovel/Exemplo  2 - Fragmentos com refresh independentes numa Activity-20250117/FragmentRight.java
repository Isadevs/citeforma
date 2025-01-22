package com.example.myapplication;

import android.graphics.Color;
import android.os.Bundle;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.TextView;
import androidx.annotation.NonNull;
import androidx.annotation.Nullable;
import androidx.fragment.app.Fragment;
import java.util.Random;

public class FragmentRight extends Fragment {

    public FragmentRight() {
        super(R.layout.fragment_right);
    }

    @Override
    public View onCreateView(@NonNull LayoutInflater inflater, @Nullable ViewGroup container, @Nullable Bundle savedInstanceState) {
        View view = inflater.inflate(R.layout.fragment_right, container, false);

        // Gera uma cor aleatória
        int color = getRandomColor();
        view.setBackgroundColor(color);

        // Atualiza o texto com a cor
        TextView textRight = view.findViewById(R.id.textRight);
        textRight.setText("Cor: #" + Integer.toHexString(color).toUpperCase());

        return view;
    }

    private int getRandomColor() {
        Random random = new Random();
        return Color.rgb(random.nextInt(256), random.nextInt(256), random.nextInt(256));
    }
}

