##########################################################################
#
#  THIS FILE IS GENERATED FROM TEMPLATE. DON'T MODIFY IT
#
#  uniee_values.py
#
#  Created on: Jan 14, 2022
#      Author: Miroslav Ondra <ondra@faster.cz>
# 


class Product:
	def __init__(self, id, name, **kwargs):
		self.id = id
		self.name = name
		self.vars = kwargs

class Board:
	def __init__(self, id, name, slots, **kwargs):
		self.id = id
		self.name = name
		self.slots = slots
		self.vars = kwargs

class Slot:
	def __init__(self, slot, **kwargs):
		self.slot = slot
		self.vars = kwargs

products = {
  '263': Product(263, 'S107', dt='unipi_s107' , udev='s107' , has_ds2482='1' ),
  '519': Product(519, 'S207', dt='unipi_s207' , udev='s207' , has_ds2482='1' ),
  '775': Product(775, 'M207', dt='unipi_m207' , udev='m207' , has_ds2482='1' ),
  '1031': Product(1031, 'M527', dt='unipi_m527' , udev='m527' , has_ds2482='1' ),
  '1287': Product(1287, 'L207', dt='unipi_l207' , udev='l207' , has_ds2482='1' ),
  '1543': Product(1543, 'L527', dt='unipi_l527' , udev='l527' , has_ds2482='1' ),
  '1799': Product(1799, 'S117', dt='unipi_s117' , udev='s117' , has_ds2482='1' ),
  '2055': Product(2055, 'M267', dt='unipi_m267' , udev='m267' , has_ds2482='1' , has_lte='1' ),
  '2311': Product(2311, 'M567', dt='unipi_m567' , udev='m567' , has_ds2482='1' , has_lte='1' ),
  '2567': Product(2567, 'S167', dt='unipi_s167' , udev='s167' , has_ds2482='1' , has_lte='1' ),
  '2823': Product(2823, 'S227', dt='unipi_s227' , udev='s227' ),
  '3079': Product(3079, 'AKUZU1', dt='unipi_akuzu1' , udev='akuzu1' , has_watchdog1='1' ),
}

boards = {
  '4': Board(4, 'B_1000_1', None),
  '5': Board(5, 'B_1000_2', None),
  '6': Board(6, 'B_1000_3', None),
  '7': Board(7, 'N_1000_1', None),
  '8': Board(8, 'N_1001_1', None),
  '9': Board(9, 'N_1002_1', None),
}

# Family names
family = {
  '1': 'UNIPI1',
  '2': 'G1XX',
  '3': 'NEURON',
  '5': 'AXON',
  '6': 'CM40',
  '7': 'PATRON',
  '15': 'IRIS',
  '16': 'OEM',
}

def unipi_product_info(product_id, version=None):
	''' return product_info or none '''
	return products.get(str(product_id), None)

def unipi_product_info_by_name(product_name, version=None):
	''' return product_info or none '''
	for k,v in products.items():
		if v.name.lower() == product_name.lower(): 
			return v
	return None

def unipi_board_info(board_id, slot=None, version=None):
	''' return board_info or None '''
	board_info = boards.get(str(board_id), None)
	if slot == None or board_info == None:
		return board_info
	if board_info.slots is None:
		return None
	return board_info.slots.get(str(slot), None)


def unipi_family_name(product_id):
	''' return family name or none '''
	return family.get(str(product_id & 0xff), None)
