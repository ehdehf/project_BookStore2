package com.boot.service;

import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.boot.mapper.BookMapper;
import com.boot.dto.BookDTO;
import com.boot.dto.GenreDTO;

@Service
public class BookServicelmpl implements BookService {

    @Autowired
    private BookMapper mapper;

    @Override
    public List<BookDTO> getAllBooks() {
        return mapper.getAllBooks();
    }

    @Override
    public List<GenreDTO> getAllGenres() {
        return mapper.getAllGenres();
    }

    @Override
    public List<BookDTO> getBooksByGenre(int genre_id) {
        return mapper.getBooksByGenre(genre_id);
    }
}