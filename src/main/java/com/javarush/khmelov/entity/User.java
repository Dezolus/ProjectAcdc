package com.javarush.khmelov.entity;

import jakarta.persistence.*;
import lombok.*;

import java.util.ArrayList;
import java.util.Collection;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Builder
@Entity
@Table(name = "users")
@ToString(exclude = {"quests","games"})
public class User implements AbstractEntity {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    private String login;

    private String password;

    @Enumerated(EnumType.STRING)
    private Role role;

    public String getImage() { //TODO move to DTO
        return "user-" + id;
    }

    @Transient
    private final Collection<Quest> quests = new ArrayList<>();

    @Transient
    private final Collection<Game> games = new ArrayList<>();
}
