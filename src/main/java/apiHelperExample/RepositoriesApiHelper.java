package apiHelperExample;

import io.restassured.http.ContentType;

import java.util.LinkedList;
import java.util.List;
import java.util.stream.Collectors;

import static io.restassured.RestAssured.given;

public class RepositoriesApiHelper {

    public Repos getReposBySearchQuery(String searchQuery) {
        return given().log().everything()
                .contentType(ContentType.JSON)
                .queryParam("q", searchQuery)
                .when().get()
                .then().log().everything()
                .extract().as(Repos.class);
    }

    public List<String> getRepoNamesForSearchQuery(String searchQuery) {
        Repos repos = getReposBySearchQuery(searchQuery);
        return repos.getItems()
                .stream()
                .map(RepoItem::getFullName)
                .collect(Collectors.toCollection(LinkedList::new));
    }
}
