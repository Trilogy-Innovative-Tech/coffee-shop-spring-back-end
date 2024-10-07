package trilogy.innovative.tech.backend.entity;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import jakarta.persistence.Table;
import lombok.Getter;
import lombok.Setter;
import org.hibernate.annotations.ColumnDefault;

@Entity
@Getter
@Setter
@Table(name = "customer")
public class Customer {
    @Id
    private String id;
    @Column(nullable = false)
    private String name;
    @Column(unique = true)
    private String email;
    private String address;
    @Column(unique = true)
    private String phone;
    private String password;
    @Column(name = "is_active")
    @ColumnDefault("true")
    private boolean isActive;
}
