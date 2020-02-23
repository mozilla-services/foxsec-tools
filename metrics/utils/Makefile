.DEFAULT_GOAL := help

help:
	@echo "Available targets:"
	@echo ""
	@echo "help     this message"
	@echo "graph    produce full SQL table graph in full.dot"
	@echo ""
	@echo "install  install the virtual environment"

graph: check_venv
	./generate_table_graph ../views/*.sql ../redash/*.sql > full.dot

check_venv:
ifeq ($(VIRTUAL_ENV),)
	$(error "Run scripts from a virtualenv (try 'make install && poetry shell')")
endif

clean: clean-cache clean-python
	rm -rf .venv
	# remember to deactivate your active virtual env


clean-python:
	find . -type d -name .venv -prune -o -type d -name __pycache__ -print0 | xargs -0 rm -rf

install: 
	poetry install


.PHONY:
	graph \
	check_venv \
	check_conftest_imports \
	clean \
	clean-cache \
	clean-python \
	install \
	.venv \

