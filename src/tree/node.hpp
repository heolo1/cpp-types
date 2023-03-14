#pragma once

#include <memory>

namespace clct {

template <typename T>
struct treenode;

template <typename T>
using s_treenode = std::shared_ptr<treenode<T>>;

template <typename T>
struct treenode {
	static void bond_left(s_treenode<T> &, s_treenode<T> &);
	static void bond_right(s_treenode<T> &, s_treenode<T> &);

	treenode(T t);
	treenode(const treenode<T> &);

	s_treenode<T> ptr() const;
	T &operator*() const;
	

private:
	std::unique_ptr<T> dat;

};

}