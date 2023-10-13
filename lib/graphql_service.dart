import 'package:flutter_application_1/book_model.dart';
import 'package:flutter_application_1/graphql_config.dart';
import 'package:graphql/client.dart';

class GraphQLService {
  static GraphQLConfig graphQLConfig = GraphQLConfig();
  GraphQLClient client = graphQLConfig.clientToQuery();

  Future<List<BookModel>> getBooks({required int limit}) async {
    try {
      QueryResult result = await client.query(
        QueryOptions(fetchPolicy: FetchPolicy.noCache, document: gql("""
          query getBooks {
            books {
              id
              title
              author
              year
            }
          }
        """), variables: {
          'limit': limit,
        }),
      );
      
      if (result.hasException){
        throw Exception(result.exception.toString());
      }

      List? res = result.data?["getBooks"];

      if(res == null || res.isEmpty) {
        return [];
      }

      List<BookModel> books = res.map((book) => BookModel.fromMap(map:book)).toList();

      return books;
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
