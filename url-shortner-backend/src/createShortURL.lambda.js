import AWS from "aws-sdk";
import { v4 as uuid } from 'uuid';

const dynamoDBInstance = () => new AWS.DynamoDB({
  region: 'ap-south-1',
});

export const handler = async (event) => {
  const { urlToShorten } = JSON.parse(event.body);
  const shortId = uuid();
  const putRequest = {
    TableName: 'AWSWorkshopDemoTable',
    Item: {
      PK: {
        S: shortId,
      },
      originalUrl: {
        S: urlToShorten,
      },
    },
  };
  try {
    await dynamoDBInstance().putItem(putRequest).promise();
  } catch (error) {
    console.log(error)
    return {
      statusCode: 500,
      body: JSON.stringify('Internal Server Error')
    }
  }
  return {
    statusCode: 200,
    body: JSON.stringify(shortId),
  };
};

export default handler;
