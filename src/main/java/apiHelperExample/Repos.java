package apiHelperExample;

import com.google.gson.annotations.SerializedName;
import lombok.Data;

import java.util.List;

@Data
public class Repos {
    @SerializedName("total_count")
    String totalCount;
    List<RepoItem> items;
}
