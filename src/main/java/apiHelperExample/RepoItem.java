package apiHelperExample;

import com.google.gson.annotations.SerializedName;
import lombok.Data;

@Data
public class RepoItem {
    String id;
    String name;
    @SerializedName("full_name")
    String fullName;
    String description;
}
