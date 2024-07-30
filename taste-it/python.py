""" A Python Class
A simple Python graph class, demonstrating the essential 
facts and functionalities of graphs.
Taken from https://www.python-course.eu/graphs_python.php
Changed the implementation a little bit to include weighted edges
"""

class Graph(object):
    def __init__(self, graph_dict=None):
        """ initializes a graph object 
            If no dictionary or None is given, 
            an empty dictionary will be used
        """
        if graph_dict == None:
            graph_dict = {}
        self.__graph_dict = graph_dict

    def vertices(self):
        """ returns the vertices of a graph """
        return list(self.__graph_dict.keys())

    def edges(self):
        """ returns the edges of a graph """
        return self.__generate_edges()

    def add_vertex(self, vertex):
        """ If the vertex "vertex" is not in 
            self.__graph_dict, a key "vertex" with an empty
            dict as a value is added to the dictionary. 
            Otherwise nothing has to be done. 
        """
        if vertex not in self.__graph_dict:
            self.__graph_dict[vertex] = {}

    def add_edge(self, edge,weight=1):
        """ assumes that edge is of type set, tuple or list
        """
        edge = set(edge)
        (vertex1, vertex2) = tuple(edge)
        if vertex1 in self.__graph_dict:
            self.__graph_dict[vertex1][vertex2] = weight
        else:
            self.__graph_dict[vertex1] = {vertex2:weight}

        if vertex2 in self.__graph_dict:
            self.__graph_dict[vertex2][vertex1] = weight
        else:
            self.__graph_dict[vertex2] = {vertex1:weight}


    def __generate_edges(self):
        """ A static method generating the edges of the 
            graph "graph". Edges are represented as sets 
            with one (a loop back to the vertex) or two 
            vertices 
        """
        edges = []
        for vertex in self.__graph_dict:
            for neighbour,weight in self.__graph_dict[vertex].iteritems():
                if (neighbour, vertex, weight) not in edges:
                    edges.append([vertex, neighbour, weight])
        return edges

    def __str__(self):
        res = "vertices: "
        for k in self.__graph_dict:
            res += str(k) + " "
        res += "\nedges: "
        for edge in self.__generate_edges():
            res += str(edge) + " "
        return res

    def adj_mat(self):
        return self.__graph_dict





