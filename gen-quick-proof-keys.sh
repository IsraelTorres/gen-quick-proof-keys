#!/bin/bash
# Israel Torres
# 20170416-135425
# ./gen-quick-proof-keys.sh
# quickly and publicly generate proof keys to show that
# one person is controlling at least two accounts at the same time
# only the person will know all three keys.
# the first account will publicly prompt the first and third keys
# the second account will publicly respond with the second key
# the first account will then publicly disclose the private solution
# in its entirety so that the witnesses can validate the keys easily
#
# modify as needed for number of accounts,
# can be easily modified for hundreds if necessary,
# as well as programmatically witnessed
#
function gen_5digpsrn () {
min=11111;max=99999; rnd=$(( $RANDOM % ($max + 1 - $min) + $min ))
echo $rnd
}

function gen_2digpsrn () {
min=11;max=99; rnd=$(( $RANDOM % ($max + 1 - $min) + $min ))
echo $rnd
}

one=$(gen_5digpsrn)
two=$(gen_2digpsrn)
thr=$((one + two))

start=$(echo "$one" | shasum -a 256 | cut -d ' ' -f 1)
middl=$(echo "$two" | shasum -a 256 | cut -d ' ' -f 1)
endsq=$(echo "$thr" | shasum -a 256 | cut -d ' ' -f 1)


echo -en "ACCOUNT ONE prompt the following challenge below:\n"
echo -en "### Begin Public Challenge ###\n"
echo -en "Challenge Keys:\n"
echo -en "First:\t$start\n"
echo -en "Third:\t$endsq\n"
echo -en "### Stop Public Challenge ###"
echo -en "\n\n"
echo -en "ACCOUNT TWO prompt the following response below:\n"
echo -en "### Begin Public Response ###\n"
echo -en "Response Key:\n"
echo -en "Second:\t$middl\n"
echo -en "### Stop Public Response ###\n"
echo -en "\n\n"
echo -en "!!! DISCLOSE BELOW ONLY WHEN WITNESSES ARE READY !!!"
echo -en "\n\n"
echo -en "### Begin Private Solution ###\n"
echo -en "Plain\tSHA-256\n"
echo -en "$one\t$start\n"
echo -en "$two\t$middl\n"
echo -en "$thr\t$endsq\n"
echo -en "### Stop Private Solution ###\n"
#
######################################################################
# --- test case 01 begin ---
# expected input (none)
#
# expected output
# >./gen-quick-proof-keys.sh
# ACCOUNT ONE prompt the following challenge below:
# ### Begin Public Challenge ###
# Challenge Keys:
# First:	03248c523a4f74a21c2fb79e8f1d37ca6c56ddd20770597ee6a709f71fed8938
# Third:	84c6b04ac5d78473c8c83023136f71e71b5f665eb93518a07ad557ebd95fbed1
# ### Stop Public Challenge ###
#
# ACCOUNT TWO prompt the following response below:
# ### Begin Public Response ###
# Response Key:
# Second:	19b8d5c59e421f037fe563007c7254eb8d98bc221b278c3db3e5fdbbfd52e273
# ### Stop Public Response ###
#
#
# !!! DISCLOSE BELOW ONLY WHEN WITNESSES ARE READY !!!
#
# ### Begin Private Solution ###
# Plain	SHA-256
# 19393	03248c523a4f74a21c2fb79e8f1d37ca6c56ddd20770597ee6a709f71fed8938
# 33	19b8d5c59e421f037fe563007c7254eb8d98bc221b278c3db3e5fdbbfd52e273
# 19426	84c6b04ac5d78473c8c83023136f71e71b5f665eb93518a07ad557ebd95fbed1
# ### Stop Private Solution ###
# >
#
# Manually calculate thusly...
# >echo 19393 | shasum -a 256
# 03248c523a4f74a21c2fb79e8f1d37ca6c56ddd20770597ee6a709f71fed8938  -
# >echo 33 | shasum -a 256
# 19b8d5c59e421f037fe563007c7254eb8d98bc221b278c3db3e5fdbbfd52e273  -
# >echo 19426 | shasum -a 256
# 84c6b04ac5d78473c8c83023136f71e71b5f665eb93518a07ad557ebd95fbed1  -
# >
# ####################################################
# --- test case 01 end ---
#
#EOF