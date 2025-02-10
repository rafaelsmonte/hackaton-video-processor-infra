const { SQSClient, SendMessageCommand } = require("@aws-sdk/client-sqs");

// Configure AWS credentials and region
const region = "us-east-1"; // Replace with your AWS region
const accessKeyId = process.env.AWS_ACCESS_KEY_ID;
const secretAccessKey = process.env.AWS_SECRET_ACCESS_KEY;

// Create an SQS client
const sqsClient = new SQSClient({
  region,
  credentials: {
    accessKeyId,
    secretAccessKey,
  },
});

const queueUrl = "https://sqs.us-east-1.amazonaws.com/839260668425/video-processor-worker-queue";

const messageBody = JSON.stringify({
    sender: "VIDEO_API_SERVICE",
    target: "VIDEO_IMAGE_PROCESSOR_SERVICE",
    type: "MSG_EXTRACT_SNAPSHOT",
    payload: {
      videoId: "27d17d29-fb62-4f49-86ab-e71aa469b4e0",
      videoName: "1739056972765-test_video.mp4",
      userId: "443864c8-c001-708b-ff93-822c9620ed43",
    }
});

const params = {
  QueueUrl: queueUrl,
  MessageBody: messageBody,
};

async function sendMessage() {
  try {
    const data = await sqsClient.send(new SendMessageCommand(params));
    console.log("Message sent successfully:", data.MessageId);
  } catch (err) {
    console.error("Error sending message:", err);
  }
}

for (i=0; i<100; i++) {
    sendMessage();
}