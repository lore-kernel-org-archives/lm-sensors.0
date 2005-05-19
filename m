From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:25:00 +0000
Subject: ADM1030/ADM1031 user-space support
Message-Id: <20040528204827.4d604c73.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20040517100022.54fae886.khali@linux-fr.org>
In-Reply-To: <20040517100022.54fae886.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Alexandre,

I am testing your new adm1031 2.4 driver and userspace support at the
moment. Here are my comments:

1* In sensors:

+  for(i=0; i<(is_1031?2:1);i++) {
+      if (!sensors_get_label_and_valid(*name, SENSORS_ADM1031_FAN1+i*10,
+				       &label, &valid)
+	  && !sensors_get_feature(*name, SENSORS_ADM1031_FAN1+i*10, &cur)
+	  && !sensors_get_feature(*name, SENSORS_ADM1031_FAN1_MIN+i*10, &low)
+	  && !sensors_get_feature(*name, SENSORS_ADM1031_FAN1_DIV+i*10, &div)
+	  ) {
+	  if (valid) {
+	      print_label(label, 10);
+	      printf("%4.0f RPM  (min = %4.0f RPM, div = %1.0f)", cur, low, div);
+	      printf(" %s\n",
+		     alarms&(ADM1031_ALARM_FAN1_FLT<<(i*8))?"FAN_FAULT":
+		     alarms&((ADM1031_ALARM_FAN1_MIN<<(i*8)))?"ALARM":"");
+	      printf("\n");

Please drop this extra new line, it breaks the display.

+	  }
+      } else
+	  printf("ERROR: Can't get fan%d data!\n", i+1);
+      free_the_label(&label);
+  }

Also, please update the default configuration file. Providing a "Fan1"
label for fan1 doesn't add much value. OTOH, labelling critical
temperatures to anything less than 10 characters would be welcome, since
long labels break the display as well.

Would be great if you could put sample limit set lines too, so that I
can test this easily.

2* I don't have fan readings. After loading the driver, I have the
following output:

fan1:     1323 RPM  (min = 1323 RPM, div = 8) 
fan2:        0 RPM  (min = 1323 RPM, div = 8) 

While both fans are spinning, rather fact as far as I can tell.

Chip dump follows:

     0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f    0123456789abcdef
00: 91 7f 00 00 5d 5d 01 00 ff 00 1f 21 1e 00 00 00    ??..]]?...?!?...
10: ff ff 5d 5d 3c 00 46 5d 50 00 64 5d 50 00 64 5d    ..]]<.F]P.d]P.d]
20: 5d 5d 55 50 41 61 61 5d 5d 5d 5d 5d 5d 5d 5d 5d    ]]UPAaa]]]]]]]]]
30: 5d 5d 5d 5d 5d 5d 5d 5d 5d 5d 5d 5d 5d 31 41 83    ]]]]]]]]]]]]]1A?

As you can see, registers read fan1=0xff, fan1_min=0xff, fan2=0x00 and
fan2_min=0xff, which almost matches the sensors output, except that
divisors are 2, not 8. So there's something broken somewhere. I don't
know if both issues (no readings and bogus divider) are related or not).

And it looks like you did not fix the 2.4 driver interface... fan* files
still yield two dozen (random) values each. This is because you forget
to set *nrels_mag to the number of values in both adm1031_fan and
adm1031_fan_div.

Temperatures readings are OK, OTOH.

Please fix these problems.

And PLEASE try your driver YOURSELF before sending it to me. You would
have noticed at least some of these problems, had you tested it. Not
that I don't like testing but we are wasting time. I'm busy so I'm slow
testing and I'd like the adm1031 stuff to be ready before we can release
lm_sensors 2.8.7. And I'd like this to happen ASAP.

Thanks.

-- 
Jean Delvare
http://khali.linux-fr.org/
