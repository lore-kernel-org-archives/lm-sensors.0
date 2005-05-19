From: greg@kroah.com (Greg KH)
Date: Thu, 19 May 2005 06:23:51 +0000
Subject: [PATCH] i2c driver changes for 2.5.66
Message-Id: <1048556321143@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
In-Reply-To: <10485563201543@kroah.com>
References: <10485563223599@kroah.com>
In-Reply-To: <10485563223599@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-kernel@vger.kernel.org, sensors@stimpy.netroedge.com

ChangeSet 1.889.357.5, 2003/03/21 16:07:30-08:00, greg@kroah.com

[PATCH] i2c: remove the data field from struct i2c_client

It's no longer needed, as the struct device should be used instead.

Created i2c_get_clientdata() and i2c_set_clientdata() to access the data.


 drivers/i2c/chips/adm1021.c |   15 +++++++--------
 drivers/i2c/chips/lm75.c    |    8 ++++----
 include/linux/i2c.h         |   11 ++++++++++-
 3 files changed, 21 insertions(+), 13 deletions(-)


diff -Nru a/drivers/i2c/chips/adm1021.c b/drivers/i2c/chips/adm1021.c
--- a/drivers/i2c/chips/adm1021.c	Mon Mar 24 17:28:15 2003
+++ b/drivers/i2c/chips/adm1021.c	Mon Mar 24 17:28:15 2003
@@ -223,8 +223,8 @@
 	}
 
 	data = (struct adm1021_data *) (new_client + 1);
+	i2c_set_clientdata(new_client, data);
 	new_client->addr = address;
-	new_client->data = data;
 	new_client->adapter = adapter;
 	new_client->driver = &adm1021_driver;
 	new_client->flags = 0;
@@ -354,8 +354,7 @@
 
 	int err;
 
-	i2c_deregister_entry(((struct adm1021_data *) (client->data))->
-				 sysctl_id);
+	i2c_deregister_entry(((struct adm1021_data *) (i2c_get_clientdata(client)))->sysctl_id);
 
 	if ((err = i2c_detach_client(client))) {
 		printk
@@ -384,7 +383,7 @@
 
 static void adm1021_update_client(struct i2c_client *client)
 {
-	struct adm1021_data *data = client->data;
+	struct adm1021_data *data = i2c_get_clientdata(client);
 
 	down(&data->update_lock);
 
@@ -435,7 +434,7 @@
 static void adm1021_temp(struct i2c_client *client, int operation,
 			 int ctl_name, int *nrels_mag, long *results)
 {
-	struct adm1021_data *data = client->data;
+	struct adm1021_data *data = i2c_get_clientdata(client);
 
 	if (operation = SENSORS_PROC_REAL_INFO)
 		*nrels_mag = 0;
@@ -462,7 +461,7 @@
 static void adm1021_remote_temp(struct i2c_client *client, int operation,
 				int ctl_name, int *nrels_mag, long *results)
 {
-	struct adm1021_data *data = client->data;
+	struct adm1021_data *data = i2c_get_clientdata(client);
 	int prec = 0;
 
 	if (operation = SENSORS_PROC_REAL_INFO)
@@ -535,7 +534,7 @@
 static void adm1021_die_code(struct i2c_client *client, int operation,
 			     int ctl_name, int *nrels_mag, long *results)
 {
-	struct adm1021_data *data = client->data;
+	struct adm1021_data *data = i2c_get_clientdata(client);
 
 	if (operation = SENSORS_PROC_REAL_INFO)
 		*nrels_mag = 0;
@@ -551,7 +550,7 @@
 static void adm1021_alarms(struct i2c_client *client, int operation,
 			   int ctl_name, int *nrels_mag, long *results)
 {
-	struct adm1021_data *data = client->data;
+	struct adm1021_data *data = i2c_get_clientdata(client);
 	if (operation = SENSORS_PROC_REAL_INFO)
 		*nrels_mag = 0;
 	else if (operation = SENSORS_PROC_REAL_READ) {
diff -Nru a/drivers/i2c/chips/lm75.c b/drivers/i2c/chips/lm75.c
--- a/drivers/i2c/chips/lm75.c	Mon Mar 24 17:28:15 2003
+++ b/drivers/i2c/chips/lm75.c	Mon Mar 24 17:28:15 2003
@@ -142,8 +142,8 @@
 	}
 
 	data = (struct lm75_data *) (new_client + 1);
+	i2c_set_clientdata(new_client, data);
 	new_client->addr = address;
-	new_client->data = data;
 	new_client->adapter = adapter;
 	new_client->driver = &lm75_driver;
 	new_client->flags = 0;
@@ -215,7 +215,7 @@
 
 static int lm75_detach_client(struct i2c_client *client)
 {
-	struct lm75_data *data = client->data;
+	struct lm75_data *data = i2c_get_clientdata(client);
 
 	i2c_deregister_entry(data->sysctl_id);
 	i2c_detach_client(client);
@@ -263,7 +263,7 @@
 
 static void lm75_update_client(struct i2c_client *client)
 {
-	struct lm75_data *data = client->data;
+	struct lm75_data *data = i2c_get_clientdata(client);
 
 	down(&data->update_lock);
 
@@ -286,7 +286,7 @@
 static void lm75_temp(struct i2c_client *client, int operation, int ctl_name,
 		      int *nrels_mag, long *results)
 {
-	struct lm75_data *data = client->data;
+	struct lm75_data *data = i2c_get_clientdata(client);
 	if (operation = SENSORS_PROC_REAL_INFO)
 		*nrels_mag = 1;
 	else if (operation = SENSORS_PROC_REAL_READ) {
diff -Nru a/include/linux/i2c.h b/include/linux/i2c.h
--- a/include/linux/i2c.h	Mon Mar 24 17:28:15 2003
+++ b/include/linux/i2c.h	Mon Mar 24 17:28:15 2003
@@ -167,12 +167,21 @@
 	  alignment considerations */
 	struct i2c_adapter *adapter;	/* the adapter we sit on	*/
 	struct i2c_driver *driver;	/* and our access routines	*/
-	void *data;			/* for the clients		*/
 	int usage_count;		/* How many accesses currently  */
 					/* to the client		*/
 	struct device dev;		/* the device structure		*/
 };
 #define to_i2c_client(d) container_of(d, struct i2c_client, dev)
+
+static inline void *i2c_get_clientdata (struct i2c_client *dev)
+{
+	return dev_get_drvdata (&dev->dev);
+}
+
+static inline void i2c_set_clientdata (struct i2c_client *dev, void *data)
+{
+	return dev_set_drvdata (&dev->dev, data);
+}
 
 /*
  * The following structs are for those who like to implement new bus drivers:
