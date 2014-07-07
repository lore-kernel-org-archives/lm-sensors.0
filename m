From: Sanford Rockowitz <rockowitz@minsoft.com>
Date: Mon, 07 Jul 2014 11:39:37 +0000
Subject: [lm-sensors] monitor ddc/ci over i2c
Message-Id: <53BA86F9.5090903@minsoft.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


I've been trying to use driver i2c-dev to read and control monitor 
settings, using the DDC/CI protocol to communicate with address 0x37 on 
device /dev/i2c-n.  Things are sort of working (details below), But it's 
not clear to me to what extent I'm hitting real limits, or if I just 
don't know what I'm doing.  Perhaps I shouldn't even be trying to use 
i2c-dev for this application.  Advice appreciated. And if there's a more 
appropriate place to post this question, I'd appreciate hearing that as 
well.

To review: A monitor is accessed via device /dev/i2c-n, created by the 
video device driver.  EDID data is found by reading address 0x50.  The 
monitor's settings are read and written at address 0x37.

I can communicate with the monitor if either the open-source nouveau or 
radeon drivers are loaded.  Both support i2c_smbus_read_i2c_block_data() 
and i2c_smbus_write_i2c_block_data(), which put the right bytes on the 
wire and handle the ack and nack bits as per the DDC specification. (See 
documentation file i2c/smbus-protocol.)

For the nouveau driver running on Fedora 20, "lsmod | grep i2c" reports:

i2c_piix4              22155  0
i2c_algo_bit           13257  1 nouveau
i2c_dev                14027  0
i2c_core               38656  6 
drm,i2c_dev,i2c_piix4,drm_kms_helper,i2c_algo_bit,nouveau


Here's a simplified example (minimal error checking) of how I'm reading 
the monitor's brightness setting:

    int fh = open("/dev/i2c-0",  O_NONBLOCK|O_RDWR);
    ioctl(fh, I2C_SLAVE, 0x37);

    unsigned char zeroByte = 0x00;
    write(fh, &zeroByte, 1);   // seems to be necessary to reset monitor 
state

    unsigned char ddc_cmd_bytes[] = {
       0x6e,              // address 0x37, shifted left 1 bit
       0x51,              // source address
       0x02 | 0x80,       // number of DDC data bytes, with high bit set
       0x01,              // DDC Get Feature Command
       0x10,              // Feature, Luminosity
       0x00,              // checksum, to be set
    };
    ddc_cmd_bytes[5] = ddc_checksum(ddc_cmd_bytes, 5);    // calculate 
DDC checksum on all bytes
    i2c_smbus_write_i2c_block_data(fh, ddc_cmd_bytes[1], 
sizeof(ddc_cmd_bytes)-2, ddc_cmd_bytes+2);
    // alt: write(fh, ddc_cmd_bytes+1, sizeof(ddc_cmd_bytes)-1); // see 
below
    usleep(5000);

    unsigned char ddc_response_bytes[12];
    unsigned char cmd_byte = 0x00;   // apparently ignored, can be anything
    i2c_smbus_read_i2c_block_data(fh, cmd_byte, 11, readbuf+1);
    // alt read(fh, readbuf+1, 11);   // see below
    ddc_response_bytes[0] = 0x50;     // for proper checksum calculation
    int calculated_checksum = ddc_checksum(readbuf, 11);
    assert(readbuf[11] = calculated_checksum);
    int response_len = ddc_response_bytes[2] & 0x7f;       // always 8 
for DDC Get Value response
    // now parse the response data


When issuing the DDC get feature command (code 0x01), a fixed data block 
of 12 data bytes is returned as shown above (as counted from the 
i2c_cmsbus_read_i2c_block_data() perspective. However, the DDC Get 
Capabilities request (0xf3), can return up to 39 bytes (fixed DDC data 
of 7 bytes plus a "fragment" of up to 32 bytes, depending on the monitor 
being communicated with.).   This is greater than the 32 byte max data 
size supported by i2c_smbus_read_i2c_block_data() (constant 
I2C_SMBUS_I2C_BLOCK_MAX in i2c-dev.h).  And indeed, I've seen 
i2c_smbus_read_i2c_block_data() return truncated responses.

Now things get interesting.

Simply using write() and read() seems to work, when the 
i2c_smbus_..._i2c_block_data() calls in the above code are replaced by 
the commented out write() and read() lines.  So apparently apparently 
write() and read() are handling the algorithm bits (start, top, ack, 
nack) properly.


Now come the key questions:

Am I just getting lucky here, or is the i2c_dev driver (or one of the 
drivers it calls) really doing the right thing for managing the 
algorithm bits for the i2c DDC protocol?

Is there a better way to use lower level services in i2c-dev?

Should I really be writing a device driver?


Finally, the proprietary video drivers.

The proprietary nvidia driver creates the /dev/i2c-n devices.  I can 
read the monitor EDID information on bus address 0x50. and get the 
functionality flags using ioctl I2C_FUNCS.   Functions 
ic2_smbus_read_i2c_block_data() and is2_smbus_write_i2c_block_data() are 
not supported (flags I2C_FUNC_SMBUS_READ_I2C_BLOCK and 
I2C_FUNC_SMBUS_WRITE_I2C_BLOCK are not set).  Attempting to call these 
functions fails with errno" (EINVAL - invalid argument) if module 
i2c_algo_bit has not been loaded, and errno=5 (EIO - IO Error) if it has.

Trying to use write() and read() as described above also fails. write() 
appears to succeed, but read() returns invalid data.

As for the proprietary fglrx driver, it doesn't even create the 
/dev/i2c-n devices.   End of story.

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
