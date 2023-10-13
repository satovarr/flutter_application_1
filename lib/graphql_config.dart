import 'package:graphql/client.dart';

class GraphQLConfig {
  static HttpLink httpLink = HttpLink(
    'https://api.github.com/graphql',
  );

  GraphQLClient clientToQuery() => GraphQLClient(link: httpLink, cache: GraphQLCache());
}

