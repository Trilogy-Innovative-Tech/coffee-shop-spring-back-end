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
@Table(name = "item_category")
public class ItemCategory {
    @Id
    @Column(name = "category_id")
    private String categoryId;
    @Column(nullable = false)
    private String description;
    @Column(name = "is_active")
    @ColumnDefault("true")
    private boolean isActive;
}
