package trilogy.innovative.tech.backend.entity;

import jakarta.persistence.*;
import lombok.Getter;
import lombok.Setter;
import org.hibernate.annotations.ColumnDefault;

@Entity
@Getter
@Setter
@Table(name = "item_sub_category")
public class ItemSubCategory {
    @Id
    @Column(name ="sub_category_id" )
    private String subCategoryId;
    @ManyToOne
    @JoinColumn(name ="category_id" ,referencedColumnName = "category_id")
    private ItemCategory category;
    @Column(nullable = false)
    private String description;
    @Column(name = "is_active")
    @ColumnDefault("true")
    private boolean isActive;
}
