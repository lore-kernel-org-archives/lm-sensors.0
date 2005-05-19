From: fdavis@si.rr.com (Frank Davis)
Date: Thu, 19 May 2005 06:23:35 +0000
Subject: 2.5.21: i2c conversion for drivers/media/video/
Message-Id: <3D2201B3.7070200@si.rr.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hello all,
   I'm hoping someone can explain the following. I want to replace the 
driver-specific write and read functions with 
i2c_smbus_write_byte(i2c_client *client, u8 data). It appears to be a 
logical switch, however, the drivers use the below functions. Can't I 
just forgot about the subaddr and use the data directly? I'm not sure 
how that will work, given that if that was done, I would be writing 
different data to the same addr (client->addr). Once I have this issue 
resolved, I believe I can write the porting guide from the old i2c API 
to the current (2.5.x) i2c API. Thanks in advance.

Regards,
Frank



I've seen the following in the old i2c drivers:

(saa7110, as example)

60 static int saa7110_write(struct saa7110 *decoder, unsigned char 
subaddr, unsigned char data)
61 {
62         int ack;
63
64         LOCK_I2C_BUS(decoder->bus);
65         i2c_start(decoder->bus);
66         i2c_sendbyte(decoder->bus, decoder->addr, I2C_DELAY);
67         i2c_sendbyte(decoder->bus, subaddr, I2C_DELAY);
68         ack = i2c_sendbyte(decoder->bus, data, I2C_DELAY);
69         i2c_stop(decoder->bus);
70         decoder->reg[subaddr] = data;
71         UNLOCK_I2C_BUS(decoder->bus);
72         return ack;
73 }
74

117 static int saa7110_selmux(struct i2c_device *device, int chan)
118 {
119 static  const unsigned char modes[9][8] = {
120 /* mode 0 */    { 0x00, 0xD9, 0x17, 0x40, 0x03, 0x44, 0x75, 0x16 },
121 /* mode 1 */    { 0x00, 0xD8, 0x17, 0x40, 0x03, 0x44, 0x75, 0x16 },
122 /* mode 2 */    { 0x00, 0xBA, 0x07, 0x91, 0x03, 0x60, 0xB5, 0x05 },
123 /* mode 3 */    { 0x00, 0xB8, 0x07, 0x91, 0x03, 0x60, 0xB5, 0x05 },
124 /* mode 4 */    { 0x00, 0x7C, 0x07, 0xD2, 0x83, 0x60, 0xB5, 0x03 },
125 /* mode 5 */    { 0x00, 0x78, 0x07, 0xD2, 0x83, 0x60, 0xB5, 0x03 },
126 /* mode 6 */    { 0x80, 0x59, 0x17, 0x42, 0xA3, 0x44, 0x75, 0x12 },
127 /* mode 7 */    { 0x80, 0x9A, 0x17, 0xB1, 0x13, 0x60, 0xB5, 0x14 },
128 /* mode 8 */    { 0x80, 0x3C, 0x27, 0xC1, 0x23, 0x44, 0x75, 0x21 } };
129         struct saa7110* decoder = device->data;
130         const unsigned char* ptr = modes[chan];
131
132         saa7110_write(decoder,0x06,ptr[0]);     /* Luminance control 
    */
133         saa7110_write(decoder,0x20,ptr[1]);     /* Analog Control #1 
    */
134         saa7110_write(decoder,0x21,ptr[2]);     /* Analog Control #2 
    */
135         saa7110_write(decoder,0x22,ptr[3]);     /* Mixer Control #1 
     */
136         saa7110_write(decoder,0x2C,ptr[4]);     /* Mixer Control #2 
     */
137         saa7110_write(decoder,0x30,ptr[5]);     /* ADCs gain control 
    */
138         saa7110_write(decoder,0x31,ptr[6]);     /* Mixer Control #3 
     */
139         saa7110_write(decoder,0x21,ptr[7]);
