import * as functions from "firebase-functions";

export const helloAlby = functions.https.onRequest((request, response) => {
  functions.logger.info("Hello logs! - Alby", { structuredData: true });
  response.send("Hello Alby!");
});
