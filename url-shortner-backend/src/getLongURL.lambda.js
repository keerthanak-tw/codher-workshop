import AWS from "aws-sdk";

const dynamoDBInstance = () => new AWS.DynamoDB({
  region: 'ap-south-1',
});

export const handler = async (event) => {
  const { shortId } = event.pathParameters;
  console.log('Invoked for ', shortId);
  console.log(`Fetching item from DB with id: ${shortId}`);
  const query = {
    Key: {
      PK: {
        S: shortId,
      },
    },
    TableName: 'some-table',
  };

  try {
    const response = await dynamoDBInstance().getItem(query).promise();
    if (!response.Item){
      return {
        statusCode: 404,
        body: JSON.stringify('Not found'),
      }
    }
    const unmarshalledResponse = AWS.DynamoDB.Converter.unmarshall(response.Item);
    return {
      statusCode: 200,
      body: JSON.stringify(unmarshalledResponse.originalUrl),
    };
  } catch (error) {
    console.log(error);
    console.log('Error while getting data. Please check the ID');
    return {
      statusCode: 500,
      body: JSON.stringify('Internal Server Error')
    }
  }
};

export default handler;
