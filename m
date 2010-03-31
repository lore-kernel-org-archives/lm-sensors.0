From: Andre Prendel <andre.prendel@gmx.de>
Date: Wed, 31 Mar 2010 20:03:53 +0000
Subject: [lm-sensors] [RFC PATCH v3 0/2] Add sensors config tool
Message-Id: <20100331200353.GA2002@andre-laptop>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Hans,

At last here is a new version of the sensors config tool.

Now we have a shell script doing the auto installation stuff. See
install.sh patch 2/2. Further I removed this part of the python
script.

As discussed, the config files from lm-sensors.org are fetched to
vendor specific directories and links are made in the root config
directory.

This looks like this:

drwxr-xr-x 2 andre andre 4096 2010-03-31 21:01 Abit
lrwxrwxrwx 1 andre andre   16 2010-03-31 21:01 Abit_AA8-DuraMAX ->Abit/AA8-DuraMAX
lrwxrwxrwx 1 andre andre   12 2010-03-31 21:01 Abit_AI7_1.0 ->Abit/AI7-1.0
lrwxrwxrwx 1 andre andre    8 2010-03-31 21:01 Abit_AN7 -> Abit/AN7
drwxr-xr-x 2 andre andre 4096 2010-03-31 21:01 ASRock
lrwxrwxrwx 1 andre andre   17 2010-03-31 21:01 ASRock_M2NF3-VSTA ->ASRock/M2NF3-VSTA
drwxr-xr-x 2 andre andre 4096 2010-03-31 21:01 Fujitsu
lrwxrwxrwx 1 andre andre   15 2010-03-31 21:01 Fujitsu_D23122A ->Fujitsu/D2312A1
lrwxrwxrwx 1 andre andre   15 2010-03-31 21:01 Fujitsu_D2312A1 ->Fujitsu/D2312A1
lrwxrwxrwx 1 andre andre   15 2010-03-31 21:01 Fujitsu_D2312C1 ->Fujitsu/D2312A1
lrwxrwxrwx 1 andre andre   15 2010-03-31 21:01 Fujitsu_D2312C2 ->Fujitsu/D2312A1
lrwxrwxrwx 1 andre andre   15 2010-03-31 21:01 Fujitsu_D2312D2_2.0 ->Fujitsu/D2312A1
lrwxrwxrwx 1 andre andre   15 2010-03-31 21:01 Fujitsu_D2314A1 ->Fujitsu/D2314A1
lrwxrwxrwx 1 andre andre   15 2010-03-31 21:01 Fujitsu_D2314A2 ->Fujitsu/D2314A1

The fetching tool parses headers like:

# board_vendor: Fujitsu
# board_name: D2312A1
# board_version: 1.0

Board version is optional. The block can appear mutliple times.

# board_vendor: Fujitsu
# board_name: D2312A1

# board_vendor: Fujitsu
# board_name: D23122A

# board_vendor: Fujitsu
# board_name: D2312C1

# board_vendor: Fujitsu
# board_name: D2312C2

The same rules apply to the product headers.

# sys_vendor: Fujitsu
# product_name: D2312D2
# product_version: 2.0

Next task is the module auto loading stuff but first, what about this
here?

Regards,
Andre

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
